// lib/services/prediction_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  static const String _apiUrl = 'https://diabetes-cahb.onrender.com/predict';

  static Future<String> predictDia(Map<String, dynamic> formData) async {
    final dataToSend = formData.map((key, value) =>
        MapEntry(key, value is String ? double.tryParse(value) ?? value : value));

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dataToSend),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['prediccion'].toString();
      } else {
        return 'Error en la predicción: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }
}
