
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../widgets/loading_but.dart';
import '../widgets/health_form_fields.dart';
import '../widgets/dia_results.dart';

class DiabetesFormScreen extends ConsumerWidget {
  const DiabetesFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(diabetesControllerProvider);
    final controller = ref.read(diabetesControllerProvider.notifier);
    const double modelAccuracy = 0.9350;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Predicción de Diabetes con IA 🤖',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.lightBlue.shade100,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.assessment, color: Colors.blue[900]),
                title: const Text('Precisión del modelo'),
                subtitle: Text('\${(modelAccuracy * 100).toStringAsFixed(2)} %'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildHealthFormFields(state.formData, (key, value) {
                      controller.updateField(key, value);
                    }),
                    const SizedBox(height: 16),
                    LoadingButton(
                      isLoading: state.isLoading,
                      onPressed: () async {
                        await controller.predict();
                      },
                      text: 'Predecir',

                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (state.prediction != null)
             DiabeticPredictionCard(predictionCode: state.prediction!),

          ],
        ),
      ),
    );
  }
}
