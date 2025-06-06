
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/prediction_service.dart';

class DiabetesState {
  final Map<String, dynamic> formData;
  final String? prediction;
  final bool isLoading;

  DiabetesState({
    required this.formData,
    this.prediction,
    this.isLoading = false,
  });

  DiabetesState copyWith({
    Map<String, dynamic>? formData,
    String? prediction,
    bool? isLoading,
  }) {
    return DiabetesState(
      formData: formData ?? this.formData,
      prediction: prediction,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DiabetesController extends StateNotifier<DiabetesState> {
  DiabetesController()
      : super(DiabetesState(formData: {
          'Age': '',
          'Sex': '0',
          'HighChol': '0',
          'CholCheck': '0',
          'BMI': '',
          'Smoker': '0',
          'Stroke': '0',
          'HeartDiseaseorAttack': '0',
          'PhysActivity': '0',
          'Fruits': '0',
          'Veggies': '0',
          'HvyAlcoholConsump': '0',
          'AnyHealthcare': '0',
          'NoDocbcCost': '0',
          'MentHlth': '0',
          'PhysHlth': '0',
        }));

  void updateField(String key, dynamic value) {
    final newFormData = Map<String, dynamic>.from(state.formData);
    newFormData[key] = value;
    state = state.copyWith(formData: newFormData);
  }

  Future<void> predict() async {
    state = state.copyWith(isLoading: true, prediction: null);
    final result = await PredictionService.predictDia(state.formData);
    state = state.copyWith(isLoading: false, prediction: result);
  }
}
