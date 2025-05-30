import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final predictionProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, formData) async {
  final apiUrl = 'https://obesity-api-1.onrender.com/predict';

  final dataToSend = formData.map((key, value) =>
      MapEntry(key, value is String ? double.tryParse(value) ?? value : value));

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['prediccion'].toString();
    } else {
      throw Exception('Error en la predicción: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
});
