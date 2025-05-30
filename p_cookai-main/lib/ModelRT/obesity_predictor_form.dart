import 'package:flutter/material.dart';
import '../services/prediction_service.dart';
import '../Grafico/prediction_card.dart';

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
    'CALC': '0',
    'FAVC': '0',
    'FCVC': '1',
    'NCP': '1',
    'SCC': '0',
    'SMOKE': '0',
    'CH2O': '1',
    'FAF': '0',
    'TUE': '0',
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

  Widget buildTextInput(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey.shade700),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.blue.shade50,
          filled: true,
        ),
        keyboardType: TextInputType.number,
        onSaved: (value) => formData[key] = value!,
        validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
      ),
    );
  }

  Widget buildDropdown(String label, String key, List<Map<String, String>> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: formData[key],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey.shade700),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.blue.shade50,
        ),
        onChanged: (value) => setState(() => formData[key] = value!),
        items: options
            .map((opt) => DropdownMenuItem<String>(
                  value: opt['value'],
                  child: Text(opt['label']!),
                ))
            .toList(),
        onSaved: (value) => formData[key] = value!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Predicción de Salud con IA 🤖',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A237E), // Azul petróleo oscuro
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        shadowColor: Colors.blueAccent.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextInput('Edad', 'Age'),
              buildDropdown('Género', 'Gender', [
                {'value': '1', 'label': 'Hombre'},
                {'value': '0', 'label': 'Mujer'},
              ]),
              buildTextInput('Peso', 'Weight'),
              buildDropdown('Frecuencia alcohol (CALC)', 'CALC', [
                {'value': '3', 'label': 'Nunca'},
                {'value': '2', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
                {'value': '0', 'label': 'Siempre'},
              ]),
              buildDropdown('¿Comes alimentos calóricos? (FAVC)', 'FAVC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Comes verduras? (FCVC)', 'FCVC', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),
              buildDropdown('Comidas por día (NCP)', 'NCP', [
                {'value': '1', 'label': 'Uno'},
                {'value': '2', 'label': 'Dos'},
                {'value': '3', 'label': 'Tres'},
                {'value': '4', 'label': 'Cuatro'},
              ]),
              buildDropdown('¿Controlas calorías? (SCC)', 'SCC', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Fumas? (SMOKE)', 'SMOKE', [
                {'value': '0', 'label': 'No'},
                {'value': '1', 'label': 'Sí'},
              ]),
              buildDropdown('¿Tomas agua? (CH2O)', 'CH2O', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '3', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuentemente'},
              ]),
              buildDropdown('Actividad física (FAF)', 'FAF', [
                {'value': '0', 'label': 'Nada'},
                {'value': '2', 'label': 'A veces'},
                {'value': '1', 'label': 'Frecuente'},
                {'value': '3', 'label': 'Diaria'},
              ]),
              buildDropdown('Uso de tecnología (TUE)', 'TUE', [
                {'value': '2', 'label': 'Nunca'},
                {'value': '1', 'label': 'A veces'},
                {'value': '0', 'label': 'Frecuente'},
              ]),
              buildDropdown('Transporte (MTRANS)', 'MTRANS', [
                {'value': '0', 'label': 'Automóvil'},
                {'value': '2', 'label': 'Motocicleta'},
                {'value': '1', 'label': 'Bicicleta'},
                {'value': '3', 'label': 'Transporte Público'},
                {'value': '4', 'label': 'Caminar'},
              ]),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _handlePrediction();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3949AB), // Azul índigo
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 5,
                  shadowColor: Colors.indigoAccent.withOpacity(0.4),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Cargando...', style: TextStyle(fontSize: 16)),
                        ],
                      )
                    : const Text(
                        'Predecir',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
              ),
              const SizedBox(height: 24),
              if (isLoading)
                Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text(
                        "Cargando resultado...",
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                )
              else if (prediction != null)
                PredictionCard(prediction: prediction!),
              const SizedBox(height: 24),
              Card(
                color: Colors.blue.shade50,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                shadowColor: Colors.blueAccent.withOpacity(0.3),
                child: ListTile(
                  leading: Icon(Icons.assessment, color: Colors.blue.shade700),
                  title: Text(
                    'Precisión del modelo',
                    style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${(modelAccuracy * 100).toStringAsFixed(2)} %',
                    style: TextStyle(color: Colors.blueGrey.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
