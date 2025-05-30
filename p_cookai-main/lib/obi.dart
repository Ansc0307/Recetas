import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    'FCVC': '',
    'NCP': '',
    'SCC': '0',
    'SMOKE': '0',
    'CH2O': '',
    'FAF': '',
    'TUE': '',
    'MTRANS': '0',
  };

  String? prediction;

  Future<void> predictObesity() async {
    //final url = Uri.parse('https://obesity-api-2.onrender.com'); // <-- Cambia por tu URL
    final url = Uri.parse('https://obesity-api-1.onrender.com/predict');  // <- correcto

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData.map((key, value) =>
            MapEntry(key, value is String ? double.tryParse(value) ?? value : value))),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          prediction = data['prediccion'].toString();
        });
      } else {
        setState(() {
          prediction = 'Error en la predicción';
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
              buildDropdown('¿Comes frecuentemente alimentos con alto contenido calórico? (FAVC)', 'FAVC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
      
               buildDropdown('¿Sueles comer verduras en tus comidas? (FCVC)', 'FCVC', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),

              buildDropdown('¿Cuántas comidas principales comes diariamente? (NCP)', 'NCP', [
                {'value': '1', 'label': 'Uno plato'},
                {'value': '2', 'label': 'Dos platos'},
                {'value': '3', 'label': 'Tres platos'},
                {'value': '4', 'label': 'Cuatro platos'},
              ]),
              buildDropdown('¿Controlas las calorías que consumes diariamente? (SCC)', 'SCC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('Fumas (SMOKE)', 'SMOKE', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
               buildDropdown('¿Tomas agua diariamente? (CH2O)', 'CH2O', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),
              
              buildDropdown('¿Con qué frecuencia realizas actividad física? (FAF)', 'FAF', [
                {'value': '0', 'label': 'Nada'},
                {'value': '2', 'label': 'Aveces'},
                {'value': '1', 'label': 'Frecuentemente'},
                {'value': '3', 'label': 'Todos los dias'},
              ]),
              buildDropdown('¿Cuánto tiempo utilizas dispositivos tecnológicos como celular, videojuegos, televisión, computadora y otros? (TUE)', 'TUE', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '2', 'label': 'A veces'},
                {'value': '0', 'label': 'Frecuentemente'},
              ]),
              buildDropdown('¿Qué transporte utilizas habitualmente? (MTRANS)', 'MTRANS', [
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
              if (prediction != null) Text('Predicción: $prediction'),
            ],
          ),
        ),
      ),
    );
  }
}
