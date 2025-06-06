import 'package:flutter/material.dart';
import 'utils/bmi_calculator.dart';
import 'utils/bmi_colors.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
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
  title: const Text(
    'Calculadora de IMC 🍽️',
    style: TextStyle(color: Colors.white), // Texto blanco
  ),
  centerTitle: true,
  backgroundColor: Colors.blue, // Fondo azul
  iconTheme: const IconThemeData(color: Colors.white), // Iconos blancos si hay
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
                color: BmiColors.getCardColor(classification),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                children: [
                  Text(
                    'Tu IMC es: ${bmi.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    classification,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: classification == 'Peso normal'
                          ? Colors.green
                          : Colors.redAccent,
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
