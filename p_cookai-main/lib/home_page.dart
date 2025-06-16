import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cookai_prototype/analysis_history_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_service.dart';
import 'widgets/section_cards.dart';
import 'analysis_history.dart'; //encarpetar en "model"
import 'history_store.dart';
import 'tts_service.dart';

class HomePage extends StatefulWidget {
  final bool esPremium;
  HomePage({required this.esPremium});
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
  final TextToSpeech _ttsController = TextToSpeech();
  Map<String, String>? _contentSections;
  bool _isSpeaking = false;

  @override
  void dispose() {
    _ttsController.stop();
    super.dispose();
  }

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
int _escaneosHoy = 0;
  Future<void> _analyzeImage() async {
    if (!widget.esPremium && _escaneosHoy >= 3) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Límite diario de 3 escaneos alcanzado para usuarios gratuitos')),
    );
    return;
  }
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
        _contentSections = _ttsController.extractSections(_contentText!);
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
    _escaneosHoy++;
  }
//-------------------------------------------------
int _escaneos=0;
Future<void> _analyzeIgredientes() async {
    if (!widget.esPremium && _escaneos >= 3) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Límite diario de 3 escaneos alcanzado para usuarios gratuitos')),
    );
    return;
  }
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
        _contentSections = _ttsController.extractSections(_contentText!);
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
    _escaneos++;
  }
  @override
  Widget _buildButtonRow() {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
          onPressed: _pickFromGallery,
          icon: const Icon(Icons.photo_library),
          label: const Text('Galería'),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
          onPressed: _takePhoto,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Cámara'),
        ),
      ),
    ],
  );
}

Widget _buildDropdownAndAnalyze() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Recetas a sugerir:", style: TextStyle(fontSize: 16, color: Colors.black87)),
      DropdownButton<int>(
        value: _numRecetas,
        items: [1, 2, 3, 4, 5].map((num) {
          return DropdownMenuItem<int>(
            value: num,
            child: Text(num.toString()),
          );
        }).toList(),
        onChanged: (value) => setState(() => _numRecetas = value!),
      ),
      const SizedBox(height: 12),
      ElevatedButton.icon(
        style: _buttonStyle(),
        onPressed: _analyzeImage,
        icon: const Icon(Icons.analytics),
        label: const Text('Analizar Imagen'),
      ),
      const SizedBox(height: 8),
      ElevatedButton.icon(
        style: _buttonStyle(),
        onPressed: _analyzeIgredientes,
        icon: const Icon(Icons.restaurant_menu),
        label: const Text('Analizar Ingredientes'),
      ),
    ],
  );
}

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurpleAccent.shade100,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  );
}

Widget _buildHistoryButton(BuildContext context) {
  return ElevatedButton.icon(
    style: _buttonStyle(),
    icon: const Icon(Icons.history),
    label: const Text("Ver historial"),
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalysisHistoryPage(esPremium: false,))),
  );
}

Widget _buildTTSControls() {
  if (!widget.esPremium) {
  return Center(
    child: Text(
      ' ',
      style: TextStyle(color: Colors.grey.shade700, fontStyle: FontStyle.italic),
    ),
  );
}
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: const Icon(Icons.replay),
        tooltip: 'Repetir',
        onPressed: _ttsController.replay,
      ),
      IconButton(
        icon: Icon(_ttsController.isSpeaking ? Icons.pause : Icons.play_arrow),
        tooltip: _ttsController.isSpeaking ? 'Pausar' : 'Reproducir',
        onPressed: () async {
          if (_isSpeaking) {
            await _ttsController.pause();
          } else {
            await _ttsController.speak(_contentText!);
          }
          setState(() => _isSpeaking = !_isSpeaking);
        },
      ),
      IconButton(
        icon: const Icon(Icons.stop),
        tooltip: 'Detener',
        onPressed: () async {
          await _ttsController.stop();
          setState(() {});
        },
      ),
    ],
  );
}

Widget _buildSectionTTSButtons() {
  if (!widget.esPremium) {
  return Center(
    child: Text(
      '🔒 Funcionalidad de voz solo disponible en versión premium.',
      style: TextStyle(color: Colors.grey.shade700, fontStyle: FontStyle.italic),
    ),
  );
}
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 8,
    children: _contentSections!.entries.map((entry) {
      return ElevatedButton.icon(
        icon: const Icon(Icons.volume_up, size: 16),
        label: Text(entry.key),
        onPressed: () => _ttsController.speak("${entry.key}: ${entry.value}"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }).toList(),
  );
}

Widget _buildRawResponseCard() {
  return Card(
    color: Colors.red.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        'Respuesta cruda:\n\n$_rawResponse',
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}

  Widget build(BuildContext context) {
    return Scaffold(
  extendBodyBehindAppBar: true,
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      'F.O.O.D.I.E.',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  ),
      body: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB2EBF2), Color(0xFFD1C4E9)], // Azul pastel a morado pastel
      ),
    ),
    child: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(_image!.path), height: 240, fit: BoxFit.cover),
              ),
            const SizedBox(height: 20),
            _buildButtonRow(),
            const SizedBox(height: 16),
            _buildDropdownAndAnalyze(),
            const SizedBox(height: 16),
            _buildHistoryButton(context),
            if (_loading) ...[
              const SizedBox(height: 20),
              const Center(child: CircularProgressIndicator()),
            ],
            if (_contentText != null && !_loading) ...[
              const SizedBox(height: 20),
              _buildTTSControls(),
              const SizedBox(height: 10),
              if (_contentSections != null) _buildSectionTTSButtons(),
              const SizedBox(height: 10),
              SectionCards(content: _contentText!),
            ],
            if (_contentText == null && _rawResponse != null && !_loading) ...[
              const SizedBox(height: 20),
              _buildRawResponseCard(),
            ],
          ],
        ),
      ),
    ),
  ),
);
  }
}
