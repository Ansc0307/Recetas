import 'package:flutter/material.dart';
import '../services/prediction_service_dia.dart';
//import 'widgets/input_field_dia.dart';
import 'widgets/loading_but.dart';
import 'widgets/health_form_fields.dart'; // Importa el nuevo archivo
import 'widgets/dia_results.dart';

class DiabeticPredictionForm extends StatefulWidget {
  @override
  _DiabeticPredictionFormState createState() => _DiabeticPredictionFormState();
}

class _DiabeticPredictionFormState extends State<DiabeticPredictionForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'Age': '',
    'Gender': '0',
    'Weight': '',
    'CALC': '3',
    'FAVC': '0',
    'FCVC': '2',
    'NCP': '1',
    'SCC': '0',
    'SMOKE': '0',
    'CH2O': '2',
    'FAF': '0',
    'TUE': '2',
    'MTRANS': '0',
  };

  String? prediction;
  final double modelAccuracy = 0.9350;
  bool isLoading = false;

  Future<void> _handlePrediction() async {
    setState(() {
      isLoading = true;
      prediction = null;
    });

    final result = await PredictionService.predictDia(formData);

    setState(() {
      prediction = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Predicción de Salud con IA 🤖',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.lightBlue.shade100,
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.assessment, color: Colors.blue[900]),
                  title: Text('Precisión del modelo'),
                  subtitle: Text('${(modelAccuracy * 100).toStringAsFixed(2)} %'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  

// ...

child: Column(
  children: [
    buildHealthFormFields(formData, () => setState(() {})),
  ],
),
),
              ),
              const SizedBox(height: 20),
              LoadingButton(
  isLoading: isLoading,
  text: 'Predecir',
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _handlePrediction();
    }
  },
  color: Colors.blue.shade700, // 👈 Aquí defines un azul más fuerte
),

              const SizedBox(height: 20),
              if (isLoading)
                Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Cargando resultado..."),
                    ],
                  ),
                )
              else if (prediction != null)
                DiabeticPredictionCard(predictionCode: prediction!),
              const SizedBox(height: 20),
            
            ],
          ),
        ),
      ),
    );
  }
}
