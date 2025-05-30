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
        'title': 'No se detecta diabetes',
        'label': 'No tienes signos de diabetes actualmente.',
        'explanation': 'Mantener un estilo de vida saludable reduce el riesgo de desarrollar diabetes en el futuro.',
        'recommendation': 'Sigue comiendo de forma balanceada, haciendo ejercicio y acudiendo a chequeos regulares.',
        'color': Colors.green,
      },
      '1': {
        'title': 'Diabetes Tipo 1 detectada',
        'label': 'Tienes indicios de diabetes tipo 1.',
        'explanation': 'Este tipo suele diagnosticarse en personas jóvenes y requiere control constante de insulina.',
        'recommendation': 'Consulta a un endocrinólogo. El tratamiento incluye insulina, monitoreo y ajustes alimenticios.',
        'color': Colors.orange,
      },
      '2': {
        'title': 'Diabetes Tipo 2 detectada',
        'label': 'Tienes indicios de diabetes tipo 2.',
        'explanation': 'Es más común en adultos y está relacionada con el estilo de vida y la alimentación.',
        'recommendation': 'Se recomienda una dieta controlada, actividad física regular y seguimiento médico frecuente.',
        'color': Colors.red,
      },
    };

    return info[code] ??
        {
          'title': 'Resultado desconocido',
          'label': 'No se pudo determinar el tipo de diabetes.',
          'explanation': 'Es posible que haya un error en el código de predicción.',
          'recommendation': 'Consulta a un profesional de salud para confirmar el diagnóstico.',
          'color': Colors.grey,
        };
  }
}
