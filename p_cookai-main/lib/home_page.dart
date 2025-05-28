import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cookai_prototype/analysis_history_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_service.dart';
import 'widgets/section_cards.dart';
import 'analysis_history.dart'; //encarpetar en "model"
import 'history_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;
  bool _loading = false;
  String? _contentText;
  String? _rawResponse;
  int _numRecetas = 2;
  final ImagePicker _picker = ImagePicker();

  void _setImage(XFile picked) {
    _image = picked;
    _contentText = null;
    _rawResponse = null;
  }

  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _setImage(picked));
  }

  Future<void> _takePhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _setImage(picked));
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;
    setState(() => _loading = true);

    try {
      //final result = await analyzeImageWithApi(File(_image!.path));
      final result = await analyzeImageWithApi(File(_image!.path), _numRecetas);
      print("🔍 CONTENIDO COMPLETO:\n${result.contentText}");
      setState(() {
        _contentText = result.contentText;
        _rawResponse = result.rawResponse;
      });
      if (_contentText != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = _image!.path.split('/').last;
        final savedImagePath = '${directory.path}/$fileName';
        await File(_image!.path).copy(savedImagePath);

        HistoryStore.addEntry(
          AnalysisEntry(
            imagePath: savedImagePath,
            content: _contentText!,
            date: DateTime.now(),
          ),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        _contentText = '❌ Error al analizar la imagen.';
        _rawResponse = null;
      });
    } finally {
      setState(() => _loading = false);
    }
  }
//-------------------------------------------------
Future<void> _analyzeIgredientes() async {
    if (_image == null) return;
    setState(() => _loading = true);

    try {
      //final result = await analyzeImageWithApi(File(_image!.path));
      final result = await analyzeIngredientesWithApi(File(_image!.path));
      print("🔍 Anlisis ingrediente:\n${result.contentText}");
      setState(() {
        _contentText = result.contentText;
        _rawResponse = result.rawResponse;
      });
      if (_contentText != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = _image!.path.split('/').last;
        final savedImagePath = '${directory.path}/$fileName';
        await File(_image!.path).copy(savedImagePath);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        _contentText = '❌ Error al analizar la imagen.';
        _rawResponse = null;
      });
    } finally {
      setState(() => _loading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NutrIA'), centerTitle: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(_image!.path), height: 240, fit: BoxFit.cover),
                  ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _pickFromGallery,
                        icon: Icon(Icons.photo_library),
                        label: Text('Galería'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: Icon(Icons.camera_alt),
                        label: Text('Cámara'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text("Recetas a sugerir:", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 12),
                    DropdownButton<int>(
                      value: _numRecetas,
                        items: [1, 2, 3, 4, 5].map((num) {
                          return DropdownMenuItem<int>(
                          value: num,
                          child: Text(num.toString()),
                        );
                      }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _numRecetas = value);
                      }
                    },
                    ),
                  SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _analyzeImage,
                  icon: Icon(Icons.analytics),
                  label: Text('Analizar Imagen'),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _analyzeIgredientes,
                  icon: Icon(Icons.analytics),
                  label: Text('Analizar Ingrediente'),
                ),
                SizedBox(height: 12),
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalysisHistoryPage())
                    );
                  }
                ),
                if (_loading) ...[
                  SizedBox(height: 20),
                  Center(child: CircularProgressIndicator()),
                ],
                if (_contentText != null && !_loading) ...[
                  SizedBox(height: 20),
                  SectionCards(content: _contentText!),
                ],
                if (_contentText == null && _rawResponse != null && !_loading) ...[
                  SizedBox(height: 20),
                  Card(
                    color: Colors.red.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Respuesta cruda:\n\n$_rawResponse',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
