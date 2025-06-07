import 'package:flutter/material.dart';

class DiabeticPredictionCard extends StatelessWidget {
  final String predictionCode;

  const DiabeticPredictionCard({required this.predictionCode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = _getDiabetesInfo(predictionCode);

    return Card(
      color: result['color'],
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Diagnóstico:',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['label'],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              '¿Por qué es importante?',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['explanation'],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              'Recomendaciones:',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['recommendation'],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getDiabetesInfo(String code) {
  final Map<String, Map<String, dynamic>> info = {
    '0': {
      'title': 'Sin indicios de diabetes',
      'label': 'Actualmente no se detectan signos de diabetes.',
      'explanation':
          'Aunque no hay señales de diabetes, es importante continuar con hábitos saludables, ya que esta enfermedad puede desarrollarse con el tiempo.',
      'recommendation':
          'Mantén una alimentación equilibrada, realiza actividad física con regularidad, evita el sedentarismo y programa chequeos médicos anuales para prevenir cualquier cambio.',
      'color': Colors.green,
    },
    '1': {
      'title': 'Posible Diabetes Tipo 1',
      'label': 'Se identifican indicios compatibles con diabetes tipo 1.',
      'explanation':
          'La diabetes tipo 1 suele aparecer a edades tempranas y se produce cuando el cuerpo deja de producir insulina. Requiere tratamiento médico constante.',
      'recommendation':
          'Consulta lo antes posible con un endocrinólogo. El tratamiento incluye insulina diaria, monitoreo continuo de glucosa y educación sobre el autocuidado. Un diagnóstico temprano mejora el control y la calidad de vida.',
      'color': Colors.orange,
    },
    '2': {
      'title': 'Posible Diabetes Tipo 2',
      'label': 'Se identifican indicios compatibles con diabetes tipo 2.',
      'explanation':
          'La diabetes tipo 2 está relacionada con factores como el sobrepeso, la alimentación y la falta de ejercicio. Puede desarrollarse gradualmente y pasar desapercibida al inicio.',
      'recommendation':
          'Agenda una cita médica para confirmar el diagnóstico. Los cambios en la dieta, el aumento de la actividad física y el control regular de glucosa son fundamentales para prevenir complicaciones.',
      'color': Colors.red,
    },
  };

  return info[code] ??
      {
        'title': 'Resultado no reconocido',
        'label': 'No se pudo determinar el diagnóstico con el código recibido.',
        'explanation':
            'Podría tratarse de un error en el procesamiento del modelo o en los datos ingresados.',
        'recommendation':
            'Te recomendamos repetir el análisis y consultar a un profesional de salud si tienes dudas o síntomas.',
        'color': Colors.grey,
      };
}

}
