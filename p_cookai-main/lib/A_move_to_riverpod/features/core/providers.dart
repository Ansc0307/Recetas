
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../diabetes/controllers/diabetes_controller.dart';

final diabetesControllerProvider =
    StateNotifierProvider<DiabetesController, DiabetesState>((ref) {
  return DiabetesController();
});
