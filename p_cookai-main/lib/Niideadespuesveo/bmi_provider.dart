import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Logic/bmi_logic.dart';

final weightProvider = StateProvider<double>((ref) => 70);
final heightProvider = StateProvider<double>((ref) => 170);

final bmiProvider = Provider<double>((ref) {
  final weight = ref.watch(weightProvider);
  final height = ref.watch(heightProvider);
  return BmiCalculator.calculateBMI(weight, height);
});

final bmiClassificationProvider = Provider<String>((ref) {
  final bmi = ref.watch(bmiProvider);
  return BmiCalculator.classifyBMI(bmi);
});
