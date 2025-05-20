import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AnalysisResult {
  final String? contentText;
  final String? rawResponse;

  AnalysisResult({this.contentText, this.rawResponse});
}

Future<AnalysisResult> analyzeImageWithApi(File imageFile) async {
  const String apiKey = 'f7841902-6ddd-46ea-bf2c-59eaab1bb17f';
  const String baseUrl = 'https://api.sambanova.ai/v1/chat/completions';

  final bytes = await imageFile.readAsBytes();
  final base64Image = base64Encode(bytes);
  final dataUri = 'data:image/${imageFile.path.split('.').last};base64,$base64Image';

  final promptText = '''
Identifica todos los ingredientes de la imagen con su nombre y cantidad aproximada (peso o volumen). Indica para cuántas porciones alcanza y clasifica el tipo de plato (entrante, principal, postre, snack). Proporciona las propiedades nutricionales por porción: calorías, proteínas, grasas, carbohidratos, fibra y vitaminas principales. Sugiere al menos dos recetas que puedan prepararse con estos ingredientes, incluyendo pasos breves de preparación. Añade consejos de conservación y posibles variaciones o sustituciones de ingredientes.
''';

  final payload = {
    'model': 'Llama-4-Maverick-17B-128E-Instruct',
    'messages': [
      {
        'role': 'user',
        'content': [
          {'type': 'text', 'text': promptText},
          {'type': 'image_url', 'image_url': {'url': dataUri}}
        ]
      }
    ],
    'temperature': 0.2,
    'top_p': 0.3
  };

  final resp = await http.post(
    Uri.parse(baseUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode(payload),
  );

  final rawResponse = resp.body;

  if (resp.statusCode == 200) {
    final Map<String, dynamic> decoded = jsonDecode(resp.body);
    final choices = decoded['choices'] as List<dynamic>?;
    final message = choices?[0]?['message'] as Map<String, dynamic>?;
    final content = message?['content'] as String?;

    if (content == null || content.trim().isEmpty) {
      return AnalysisResult(
          contentText:
              '⚠️ La API no devolvió ninguna descripción útil. Intenta con otra imagen.',
          rawResponse: rawResponse);
    } else {
      return AnalysisResult(contentText: content.trim(), rawResponse: rawResponse);
    }
  } else {
    return AnalysisResult(
        contentText: '⚠️ Error: código de estado ${resp.statusCode}', rawResponse: rawResponse);
  }
}
