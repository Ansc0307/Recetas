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

      buildDropdown('Sexo', 'Sex', formData, [
        {'value': '0', 'label': 'Mujer'},
        {'value': '1', 'label': 'Hombre'},
      ], onChanged: (value) {
        formData['Sex'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('Colesterol alto (HighChol)', 'HighChol', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HighChol'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('Chequeo de colesterol (CholCheck)', 'CholCheck', formData, [
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

      buildDropdown('¿Fuma? (Smoker)', 'Smoker', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Smoker'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Ha tenido un ACV? (Stroke)', 'Stroke', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Stroke'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Enfermedad o ataque cardíaco?', 'HeartDiseaseorAttack', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HeartDiseaseorAttack'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Actividad física? (PhysActivity)', 'PhysActivity', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['PhysActivity'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consume frutas? (Fruits)', 'Fruits', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Fruits'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consume verduras? (Veggies)', 'Veggies', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['Veggies'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Consumo elevado de alcohol? (HvyAlcoholConsump)', 'HvyAlcoholConsump', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['HvyAlcoholConsump'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿Tiene acceso a salud? (AnyHealthcare)', 'AnyHealthcare', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['AnyHealthcare'] = value;
      }),
      const SizedBox(height: 10),

      buildDropdown('¿No consultó por costo? (NoDocbcCost)', 'NoDocbcCost', formData, [
        {'value': '0', 'label': 'No'},
        {'value': '1', 'label': 'Sí'},
      ], onChanged: (value) {
        formData['NoDocbcCost'] = value;
      }),
      const SizedBox(height: 10),

      buildTextInput(
        'Días de mala salud mental (MentHlth)', 'MentHlth', formData,
        maxValue: 30, minValue: 0,
        onChanged: (value) => formData['MentHlth'] = value,
      ),
      const SizedBox(height: 10),

      buildTextInput(
        'Días de mala salud física (PhysHlth)', 'PhysHlth', formData,
        maxValue: 30, minValue: 0,
        onChanged: (value) => formData['PhysHlth'] = value,
      ),
      const SizedBox(height: 10),
    ],
  );
}
