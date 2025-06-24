import 'package:flutter/material.dart';

class PredictionCard extends StatelessWidget {
  final String prediction;

  const PredictionCard({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    final result = _getPredictionInfo(prediction);

    return Card(
      color: result['color'],
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resultado: ${result['label']}',
            
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),

            ),
            const SizedBox(height: 8),
            Text(
              result['recommendation'],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),

              
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPredictionInfo(String code) {
    final Map<String, Map<String, dynamic>> labels = {
      '0': {
        'label': 'Insufficient Weight',
        'recommendation': 'Aumenta tu ingesta calórica y consulta un nutricionista.',
        'color': Colors.lightBlue,
      },
      '1': {
        'label': 'Normal Weight',
        'recommendation': '¡Sigue con tu estilo de vida saludable!',
        'color': Colors.green,
      },
      '2': {
        'label': 'Obesity Type I',
        'recommendation': 'Requiere atención médica. Mejora tu dieta y realiza ejercicio.',
        'color': Colors.orange,
      },
      '3': {
        'label': 'Obesity Type II',
        'recommendation': 'Busca apoyo profesional. Necesario cambio en estilo de vida.',
        'color': Colors.deepOrange,
      },
      '4': {
        'label': 'Obesity Type III',
        'recommendation': 'Obesidad severa. Se recomienda intervención médica urgente.',
        'color': Colors.red,
      },
      '5': {
        'label': 'Overweight Level I',
        'recommendation': 'Comienza con ajustes alimenticios y actividad física moderada.',
        'color': Colors.yellow.shade700,
      },
      '6': {
        'label': 'Overweight Level II',
        'recommendation': 'Importante controlar alimentación y aumentar actividad física.',
        'color': Colors.amber,
      },
    };

    return labels[code] ??
        {
          'label': 'Desconocido',
          'recommendation': 'No se pudo interpretar la predicción.',
          'color': Colors.grey,
        };
  }
}
