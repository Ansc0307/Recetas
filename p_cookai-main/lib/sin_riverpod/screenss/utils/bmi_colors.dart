import 'package:flutter/material.dart';

class BmiColors {
  static Color getCardColor(String classification) {
    switch (classification) {
      case 'Delgadez severa':
      case 'Delgadez moderada':
      case 'Delgadez leve':
        return Colors.orange.shade100;
      case 'Peso normal':
        return Colors.green.shade100;
      case 'Sobrepeso':
        return Colors.yellow.shade100;
      case 'Obesidad grado I':
        return Colors.orange.shade200;
      case 'Obesidad grado II':
        return Colors.deepOrange.shade200;
      case 'Obesidad grado III (mórbida)':
        return Colors.red.shade200;
      default:
        return Colors.blue.shade50;
    }
  }
}
