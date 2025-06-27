import 'package:flutter/material.dart';

class BmiCalculator {
  static double calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static String classifyBMI(double bmi) {
    if (bmi < 16.0) return 'Delgadez severa';
    if (bmi >= 16.0 && bmi < 17.0) return 'Delgadez moderada';
    if (bmi >= 17.0 && bmi < 18.5) return 'Delgadez leve';
    if (bmi >= 18.5 && bmi < 25.0) return 'Peso normal';
    if (bmi >= 25.0 && bmi < 30.0) return 'Sobrepeso';
    if (bmi >= 30.0 && bmi < 35.0) return 'Obesidad grado I';
    if (bmi >= 35.0 && bmi < 40.0) return 'Obesidad grado II';
    return 'Obesidad grado III (mórbida)';
  }

  static String getRecommendation(double bmi) {
    if (bmi < 16.0) {
      return 'Es importante buscar atención médica. Aumenta tu ingesta calórica con alimentos nutritivos.';
    } else if (bmi < 17.0) {
      return 'Incluye más proteínas y carbohidratos saludables. Consulta a un nutricionista.';
    } else if (bmi < 18.5) {
      return 'Podrías beneficiarte de una dieta más calórica. Considera añadir snacks saludables.';
    } else if (bmi < 25.0) {
      return '¡Buen trabajo! Mantén una dieta equilibrada y realiza actividad física regular.';
    } else if (bmi < 30.0) {
      return 'Reduce el consumo de alimentos procesados y aumenta tu actividad física.';
    } else if (bmi < 35.0) {
      return 'Considera un plan de alimentación saludable. Es recomendable consultar con un profesional.';
    } else {
      return 'Busca orientación médica para crear un plan de pérdida de peso seguro y efectivo.';
    }
  }
}
