import 'package:flutter/material.dart';

class LifestylePredictionCard extends StatelessWidget {
  final String predictionCode;

  const LifestylePredictionCard({required this.predictionCode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = _getPredictionInfo(predictionCode);

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
              'Posiblemente tengas:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['label'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              '¿Por qué es importante?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['explanation'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              'Recomendaciones:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              result['recommendation'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            if (result['advice'] != null && result['advice'].isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                '¿Qué puedes hacer mejor?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                result['advice'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPredictionInfo(String code) {
    final Map<String, Map<String, dynamic>> info = {
      '0': {
        'title': 'Tu estilo de vida necesita atención',
         'label': 'Peso Insuficiente',
        'explanation': 'Actualmente, algunos hábitos pueden estar afectando tu salud y energía.',
        'recommendation': 'Es importante mejorar tu alimentación y consultar a un profesional.',
        'advice': 'Incluye más alimentos naturales y realiza actividad física moderada varias veces por semana.',
        'color': Colors.lightBlue,
      },
      '1': {
        'title': 'Tu estilo de vida está bien, sigue así',
        'label': 'Peso Normal',
        'explanation': 'Mantener hábitos saludables ayuda a prevenir enfermedades y mantener energía.',
        'recommendation': 'Sigue con una dieta balanceada y ejercicio regular.',
        'advice': 'Continúa monitoreando tu salud y adapta hábitos según tus necesidades.',
        'color': Colors.green,
      },
      '2': {
        'title': 'Es momento de hacer algunos cambios',
        'label': 'Obesidad Tipo I',
        'explanation': 'Hay señales de que ciertos hábitos podrían afectar tu bienestar a largo plazo.',
        'recommendation': 'Mejora tu alimentación y aumenta tu actividad física con ayuda profesional.',
        'advice': 'Reduce consumo de alimentos procesados y azúcares; incorpora más frutas y verduras.',
        'color': Colors.orange,
      },
      '3': {
        'title': 'Necesitas apoyo para mejorar tu salud',
         'label': 'Obesidad Tipo II',
        'explanation': 'Tu estilo de vida puede estar generando riesgos importantes para tu salud.',
        'recommendation': 'Busca ayuda profesional para crear un plan adecuado para ti.',
        'advice': 'Realiza cambios graduales y busca acompañamiento de especialistas.',
        'color': Colors.deepOrange,
      },
      '4': {
        'title': 'Es urgente hacer cambios en tu estilo de vida',
         'label': 'Obesidad Tipo III',
        'explanation': 'Tu salud está en riesgo y requiere atención médica inmediata.',
        'recommendation': 'Consulta a profesionales y considera tratamientos especializados.',
        'advice': 'Evita automedicación y sigue las indicaciones médicas al pie de la letra.',
        'color': Colors.red,
      },
      '5': {
        'title': 'Puedes mejorar tu estilo de vida',
        'label': 'Sobrepeso Nivel I',
        'explanation': 'Hay aspectos que puedes ajustar para mejorar tu bienestar general.',
        'recommendation': 'Empieza con pequeños cambios en alimentación y actividad física.',
        'advice': 'Controla porciones y realiza caminatas diarias para ganar hábitos saludables.',
        'color': Colors.yellow.shade700,
      },
      '6': {
        'title': 'Es importante tomar medidas pronto',
        'label': 'Sobrepeso Nivel II',
        'explanation': 'Tu estilo de vida actual podría llevar a problemas de salud si no cambias.',
        'recommendation': 'Consulta a profesionales y realiza un plan de cambio sostenible.',
        'advice': 'Lleva un registro de alimentos y ejercicio, y evita el sedentarismo.',
        'color': Colors.amber,
      },
    };

    return info[code] ??
        {
          'title': 'Resultado desconocido',
           'label': 'Desconocido',
          'explanation': 'No se pudo interpretar el resultado.',
          'recommendation': 'Consulta a un especialista para una evaluación más completa.',
          'advice': '',
          'color': Colors.grey,
        };
  }


}
