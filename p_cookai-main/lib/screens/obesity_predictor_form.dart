import 'package:flutter/material.dart';
import '../services/prediction_service.dart';
import 'widgets/input_fields.dart';
import 'widgets/loading_button.dart';
import 'widgets/prediction_result_card.dart';

class ObesityPredictorForm extends StatefulWidget {
  @override
  _ObesityPredictorFormState createState() => _ObesityPredictorFormState();
}

class _ObesityPredictorFormState extends State<ObesityPredictorForm> {
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

    final result = await PredictionService.predictObesity(formData);

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
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildTextInput('Edad', 'Age', formData, onChanged: (value) {
                        formData['Age'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Género', 'Gender', formData, [
                        {'value': '1', 'label': 'Hombre'},
                        {'value': '0', 'label': 'Mujer'},
                      ], onChanged: (value) {
                        formData['Gender'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildTextInput('Peso', 'Weight', formData, onChanged: (value) {
                        formData['Weight'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Frecuencia alcohol (CALC)', 'CALC', formData, [
                        {'value': '3', 'label': 'Nunca'},
                        {'value': '2', 'label': 'A veces'},
                        {'value': '1', 'label': 'Frecuentemente'},
                        {'value': '0', 'label': 'Siempre'},
                      ], onChanged: (value) {
                        formData['CALC'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('¿Comes alimentos calóricos? (FAVC)', 'FAVC', formData, [
                        {'value': '0', 'label': 'No'},
                        {'value': '1', 'label': 'Sí'},
                      ], onChanged: (value) {
                        formData['FAVC'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('¿Comes verduras? (FCVC)', 'FCVC', formData, [
                        {'value': '2', 'label': 'Nunca'},
                        {'value': '3', 'label': 'A veces'},
                        {'value': '1', 'label': 'Frecuentemente'},
                      ], onChanged: (value) {
                        formData['FCVC'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Comidas por día (NCP)', 'NCP', formData, [
                        {'value': '1', 'label': 'Uno'},
                        {'value': '2', 'label': 'Dos'},
                        {'value': '3', 'label': 'Tres'},
                        {'value': '4', 'label': 'Cuatro'},
                      ], onChanged: (value) {
                        formData['NCP'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('¿Controlas calorías? (SCC)', 'SCC', formData, [
                        {'value': '0', 'label': 'No'},
                        {'value': '1', 'label': 'Sí'},
                      ], onChanged: (value) {
                        formData['SCC'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('¿Fumas? (SMOKE)', 'SMOKE', formData, [
                        {'value': '0', 'label': 'No'},
                        {'value': '1', 'label': 'Sí'},
                      ], onChanged: (value) {
                        formData['SMOKE'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('¿Tomas agua? (CH2O)', 'CH2O', formData, [
                        {'value': '2', 'label': 'Nunca'},
                        {'value': '3', 'label': 'A veces'},
                        {'value': '1', 'label': 'Frecuentemente'},
                      ], onChanged: (value) {
                        formData['CH2O'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Actividad física (FAF)', 'FAF', formData, [
                        {'value': '0', 'label': 'Nada'},
                        {'value': '2', 'label': 'A veces'},
                        {'value': '1', 'label': 'Frecuente'},
                        {'value': '3', 'label': 'Diaria'},
                      ], onChanged: (value) {
                        formData['FAF'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Uso de tecnología (TUE)', 'TUE', formData, [
                        {'value': '2', 'label': 'Nunca'},
                        {'value': '1', 'label': 'A veces'},
                        {'value': '0', 'label': 'Frecuente'},
                      ], onChanged: (value) {
                        formData['TUE'] = value;
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('Transporte (MTRANS)', 'MTRANS', formData, [
                        {'value': '0', 'label': 'Automóvil'},
                        {'value': '2', 'label': 'Motocicleta'},
                        {'value': '1', 'label': 'Bicicleta'},
                        {'value': '3', 'label': 'Transporte Público'},
                        {'value': '4', 'label': 'Caminar'},
                      ], onChanged: (value) {
                        formData['MTRANS'] = value;
                      }),
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
                LifestylePredictionCard(predictionCode: prediction!),
              const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
