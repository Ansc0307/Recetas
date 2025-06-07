
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/bmi_notifier.dart';
import '../shared/bmi_colors.dart';

class BmiScreen extends ConsumerWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bmiNotifierProvider);
    final notifier = ref.read(bmiNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Height: ${state.height.toStringAsFixed(1)} cm'),
            Slider(
              value: state.height,
              min: 100,
              max: 220,
              label: state.height.toStringAsFixed(1),
              onChanged: notifier.updateHeight,
            ),
            const SizedBox(height: 20),
            Text('Weight: ${state.weight.toStringAsFixed(1)} kg'),
            Slider(
              value: state.weight,
              min: 30,
              max: 200,
              label: state.weight.toStringAsFixed(1),
              onChanged: notifier.updateWeight,
            ),
            const SizedBox(height: 40),
            if (state.bmi != null)
              Column(
                children: [
                  Text(
                    'BMI: ${state.bmi!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      color: BmiColors.getCardColor(state.category ?? ''),

                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.category ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
