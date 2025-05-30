import 'package:flutter/material.dart';

Widget buildTextInput(
  String label,
  String keyName,
  Map<String, dynamic> formData, {
  required Function(String) onChanged,
}) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),
    keyboardType: TextInputType.number,
    initialValue: formData[keyName],
    onChanged: onChanged,
    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
    onSaved: (value) => formData[keyName] = value!,
  );
}

Widget buildDropdown(
  String label,
  String keyName,
  Map<String, dynamic> formData,
  List<Map<String, String>> options, {
  required Function(String) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: formData[keyName],
    decoration: InputDecoration(labelText: label),
    onChanged: (value) {
      if (value != null) onChanged(value);
    },
    items: options
        .map((opt) => DropdownMenuItem<String>(
              value: opt['value'],
              child: Text(opt['label']!),
            ))
        .toList(),
    onSaved: (value) => formData[keyName] = value!,
  );
}
