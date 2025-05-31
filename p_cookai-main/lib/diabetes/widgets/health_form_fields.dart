// lib/widgets/health_form_fields.dart
import 'package:flutter/material.dart';
import 'input_field_dia.dart'; // asegúrate de importar tus utilidades

Widget buildHealthFormFields(Map<String, dynamic> formData, Function setStateCallback) {
  return Column(
    children: [
      buildTextInput('Edad', 'Age', formData, onChanged: (value) {
        formData['Age'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('Sexo biológico', 'Sex', formData, [
        {'value': '0', 'label': 'Mujer'},
        {'value': '1', 'label': 'Hombre'},
      ], onChanged: (value) {
        formData['Sex'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Colesterol alto diagnosticado?', 'HighChol', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HighChol'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Chequeo de colesterol en los últimos 5 años?', 'CholCheck', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['CholCheck'] = value;
      }),
      const SizedBox(height: 10),

      buildTextInput('Índice de Masa Corporal (BMI)', 'BMI', formData, onChanged: (value) {
        formData['BMI'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Ha fumado al menos 100 cigarrillos en su vida?', 'Smoker', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Smoker'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Le han diagnosticado un ACV (derrame cerebral)?', 'Stroke', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Stroke'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Ha tenido enfermedad coronaria o ataque cardíaco?', 'HeartDiseaseorAttack', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HeartDiseaseorAttack'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Actividad física en los últimos 30 días (fuera del trabajo)?', 'PhysActivity', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['PhysActivity'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consume frutas una vez o más al día?', 'Fruits', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Fruits'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consume verduras una vez o más al día?', 'Veggies', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Veggies'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consumo excesivo de alcohol (bajo criterios clínicos)?', 'HvyAlcoholConsump', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HvyAlcoholConsump'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Tiene algún tipo de acceso a atención médica?', 'AnyHealthcare', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['AnyHealthcare'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Ha evitado consultar por motivos económicos?', 'NoDocbcCost', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['NoDocbcCost'] = value;
      }),
      const SizedBox(height: 10),

      buildTextInput(
        'Días con mala salud mental (últimos 30 días)', 'MentHlth', formData,
        maxValue: 30, minValue: 0,
        onChanged: (value) => formData['MentHlth'] = value,
      ),
      const SizedBox(height: 10),

      buildTextInput(
        'Días con mala salud física (últimos 30 días)', 'PhysHlth', formData,
        maxValue: 30, minValue: 0,
        onChanged: (value) => formData['PhysHlth'] = value,
      ),
      const SizedBox(height: 10),
    ],
  );
}
