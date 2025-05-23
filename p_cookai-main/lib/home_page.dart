import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_service.dart';
import 'widgets/section_cards.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;
  bool _loading = false;
  String? _contentText;
  String? _rawResponse;

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
      final result = await analyzeImageWithApi(File(_image!.path));
      setState(() {
        _contentText = result.contentText;
        _rawResponse = result.rawResponse;
      });
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
      appBar: AppBar(title: Text('Llama 4 Vision Maverick'), centerTitle: true),
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
                ElevatedButton.icon(
                  onPressed: _analyzeImage,
                  icon: Icon(Icons.analytics),
                  label: Text('Analizar Imagen'),
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
