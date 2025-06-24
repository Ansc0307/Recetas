import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Niideadespuesveo/bmi_provider.dart';

class BmiScreen extends ConsumerWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weight = ref.watch(weightProvider);
    final height = ref.watch(heightProvider);
    final bmi = ref.watch(bmiProvider);
    final classification = ref.watch(bmiClassificationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final w = double.tryParse(value);
                if (w != null) ref.read(weightProvider.notifier).state = w;
              },
              controller: TextEditingController(text: weight.toString()),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final h = double.tryParse(value);
                if (h != null) ref.read(heightProvider.notifier).state = h;
              },
              controller: TextEditingController(text: height.toString()),
            ),
            const SizedBox(height: 32),
            Text(
              'Your BMI is: ${bmi.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              classification,
              style: TextStyle(
                fontSize: 20,
                color: classification == 'Normal weight' ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
