import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante Saludable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F8FB),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const BmiScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

Color _getCardColor(String classification) {
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


class _BmiScreenState extends State<BmiScreen> {
  double weight = 70;
  double height = 170;

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double bmi = 0;
  String classification = '';
  String recommendation = '';

  @override
  void initState() {
    super.initState();
    weightController.text = weight.toString();
    heightController.text = height.toString();
    _updateBMI();
  }

  void _updateBMI() {
    setState(() {
      bmi = BmiCalculator.calculateBMI(weight, height);
      classification = BmiCalculator.classifyBMI(bmi);
      recommendation = BmiCalculator.getRecommendation(bmi);
    });
  }

  void _onWeightChanged(String value) {
    final w = double.tryParse(value);
    if (w != null) {
      weight = w;
      _updateBMI();
    }
  }

  void _onHeightChanged(String value) {
    final h = double.tryParse(value);
    if (h != null) {
      height = h;
      _updateBMI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC 🍽️'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Bienvenido a Restaurante Saludable',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Calcula tu Índice de Masa Corporal y cuida tu salud con nosotros.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                prefixIcon: Icon(Icons.fitness_center),
              ),
              onChanged: _onWeightChanged,
              controller: weightController,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                prefixIcon: Icon(Icons.height),
              ),
              onChanged: _onHeightChanged,
              controller: heightController,
            ),
            const SizedBox(height: 30),
           Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: _getCardColor(classification), // Cambia aquí
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.blue.shade100),
  ),
  child: Column(
    children: [
      Text(
        'Tu IMC es: ${bmi.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      const SizedBox(height: 8),
      Text(
        classification,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: classification == 'Peso normal' ? Colors.green : Colors.redAccent,
        ),
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}

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

  static Color classifyColor(double bmi) {
    if (bmi < 18.5) return Colors.orange;
    if (bmi < 25.0) return Colors.green;
    if (bmi < 30.0) return Colors.amber;
    if (bmi < 35.0) return Colors.deepOrange;
    return Colors.red;
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
