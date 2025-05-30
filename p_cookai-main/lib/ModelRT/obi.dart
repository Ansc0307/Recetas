import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Grafico/prediction_card.dart';

void main() => runApp(MaterialApp(home: ObesityPredictorForm()));

class ObesityPredictorForm extends StatefulWidget {
  @override
  _ObesityPredictorFormState createState() => _ObesityPredictorFormState();
}

class _ObesityPredictorFormState extends State<ObesityPredictorForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'Age': '',
    'Gender': '0',
    'Weight': '',
    'CALC': '0',
    'FAVC': '0',
    'FCVC': '1',
    'NCP': '1',
    'SCC': '0',
    'SMOKE': '0',
    'CH2O': '1',
    'FAF': '0',
    'TUE': '0',
    'MTRANS': '0',
  };

  String? prediction;
  final double modelAccuracy = 0.9350;

  Future<void> predictObesity() async {
    final url = Uri.parse('https://obesity-api-1.onrender.com/predict');

    final dataToSend = formData.map((key, value) =>
        MapEntry(key, value is String ? double.tryParse(value) ?? value : value));

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dataToSend),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          prediction = data['prediccion'].toString();
        });
      } else {
        setState(() {
          prediction = 'Error en la predicción: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        prediction = 'Error de conexión: $e';
      });
    }
  }

  Widget buildTextInput(String label, String key) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onSaved: (value) => formData[key] = value!,
      validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
    );
  }

  Widget buildDropdown(String label, String key, List<Map<String, String>> options) {
    return DropdownButtonFormField<String>(
      value: formData[key],
      decoration: InputDecoration(labelText: label),
      onChanged: (value) => setState(() => formData[key] = value!),
      items: options
          .map((opt) => DropdownMenuItem<String>(
                value: opt['value'],
                child: Text(opt['label']!),
              ))
          .toList(),
      onSaved: (value) => formData[key] = value!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Predicción de Obesidad')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextInput('Edad', 'Age'),
              buildDropdown('Género', 'Gender', [
                {'value': '1', 'label': 'Hombre'},
                {'value': '0', 'label': 'Mujer'},
              ]),
              buildTextInput('Peso', 'Weight'),
              buildDropdown('Frecuencia alcohol (CALC)', 'CALC', [
                {'value': '3', 'label': 'Nunca'},
                {'value': '2', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
                {'value': '0', 'label': 'Siempre'},
              ]),
              buildDropdown('¿Comes frecuentemente alimentos calóricos? (FAVC)', 'FAVC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Sueles comer verduras? (FCVC)', 'FCVC', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),
              buildDropdown('Comidas principales al día (NCP)', 'NCP', [
                {'value': '1', 'label': 'Uno'},
                {'value': '2', 'label': 'Dos'},
                {'value': '3', 'label': 'Tres'},
                {'value': '4', 'label': 'Cuatro'},
              ]),
              buildDropdown('¿Controlas calorías? (SCC)', 'SCC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Fumas? (SMOKE)', 'SMOKE', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Tomas agua? (CH2O)', 'CH2O', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),
              buildDropdown('Actividad física (FAF)', 'FAF', [
                {'value': '0', 'label': 'Nada'},
                {'value': '2', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuente'},
                {'value': '3', 'label': 'Diaria'},
              ]),
              buildDropdown('Uso de tecnología (TUE)', 'TUE', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '1', 'label': 'A veces'},
                {'value': '0', 'label': 'Frecuente'},
              ]),
              buildDropdown('Medio de transporte (MTRANS)', 'MTRANS', [
                {'value': '0', 'label': 'Automóvil'},
                {'value': '2', 'label': 'Motocicleta'},
                {'value': '1', 'label': 'Bicicleta'},
                {'value': '3', 'label': 'Transporte Público'},
                {'value': '4', 'label': 'Caminar'},
              ]),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    predictObesity();
                  }
                },
                child: Text('Predecir'),
              ),
              SizedBox(height: 20),
              if (prediction != null) PredictionCard(prediction: prediction!),
              SizedBox(height: 20),
              Card(
                color: Colors.blue.shade50,
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.assessment, color: Colors.blue),
                  title: Text('Precisión del modelo'),
                  subtitle: Text('${(modelAccuracy * 100).toStringAsFixed(2)} %'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
