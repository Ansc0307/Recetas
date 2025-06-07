
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bmi/domain/bmi_calculator.dart';

final bmiNotifierProvider = NotifierProvider<BmiNotifier, BmiState>(BmiNotifier.new);

class BmiState {
  final double height;
  final double weight;
  final double? bmi;
  final String? category;

  BmiState({
    this.height = 170,
    this.weight = 70,
    this.bmi,
    this.category,
  });

  BmiState copyWith({
    double? height,
    double? weight,
    double? bmi,
    String? category,
  }) {
    return BmiState(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      category: category ?? this.category,
    );
  }
}

class BmiNotifier extends Notifier<BmiState> {
  @override
  BmiState build() => BmiState();

  void updateHeight(double newHeight) {
    state = state.copyWith(height: newHeight);
    _recalculate();
  }

  void updateWeight(double newWeight) {
    state = state.copyWith(weight: newWeight);
    _recalculate();
  }

  void _recalculate() {
  final bmi = BmiCalculator.calculateBMI(state.weight, state.height);
  final category = BmiCalculator.classifyBMI(bmi);
  state = state.copyWith(bmi: bmi, category: category);
}

}
