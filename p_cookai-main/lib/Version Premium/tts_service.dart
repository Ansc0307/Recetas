import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts _tts = FlutterTts();
   bool _isSpeaking = false;
  String _currentText = '';
   // Getter público para el estado de habla
  bool get isSpeaking => _isSpeaking;
  
  // Getter público para el texto actual
  String get currentText => _currentText;

  // Método público para parsear y limpiar texto
  String prepareForSpeech(String originalText) {
    return parseContentForTTS(originalText);
  }

  Future<void> speak(String text) async {
    _currentText = text;
    final cleanText = prepareForSpeech(text);
    await _tts.setLanguage("es-ES");
    await _tts.setPitch(1.0);
    await _tts.speak(cleanText);
    _isSpeaking = true;
  }
  Future<void> pause() async {
    if (_isSpeaking) {
      await _tts.pause();
      _isSpeaking = false;
    }
  }

  Future<void> replay() async {
    await stop();
    await speak(_currentText);
  }

  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  // Métodos privados para procesamiento interno
  String cleanTextForTTS(String originalText) {
  // Expresiones regulares para eliminar formato no deseado
  final markdownHeaders = RegExp(r'#{1,6}\s*');
  final markdownBold = RegExp(r'\*{2}(.*?)\*{2}');
  final markdownLists = RegExp(r'^\s*[\-\*\+]\s*', multiLine: true);
  final sectionMarkers = RegExp(r'###\s*');
  final extraSpaces = RegExp(r'\s+');
  final specialChars = RegExp(r'[^\w\s.,;:áéíóúÁÉÍÓÚñÑ¿?¡!]');

  return originalText
      .replaceAll(markdownHeaders, '')       // Elimina ### Encabezados
      .replaceAllMapped(markdownBold, (match) => match.group(1) ?? '') // Mantiene solo el texto en negrita
      .replaceAll(markdownLists, '')         // Elimina viñetas (-, *, +)
      .replaceAll(sectionMarkers, '')        // Elimina marcadores de sección
      .replaceAll(specialChars, ' ')         // Reemplaza caracteres especiales
      .replaceAll(extraSpaces, ' ')          // Reduce espacios múltiples
      .trim();
}

  String parseContentForTTS(String originalText) {
  final sections = originalText.split(RegExp(r'###\s*'));
  final relevantSections = [
    'Ingredientes',
    'Porciones',
    'Propiedades nutricionales',
    'Recetas sugeridas',
    'Conservación y sustituciones'
  ];

  final buffer = StringBuffer();
  
  for (final section in sections) {
    for (final title in relevantSections) {
      if (section.startsWith(title)) {
        final content = section.substring(title.length).trim();
        buffer.writeln("$title: $content");
        break;
      }
    }
  }
  
  return buffer.toString().isNotEmpty 
      ? cleanTextForTTS(buffer.toString())
      : cleanTextForTTS(originalText);
}
 Map<String, String> extractSections(String originalText) {
    final sections = originalText.split(RegExp(r'###\s*'));
    final Map<String, String> result = {};
    
    const sectionTitles = [
      'Ingredientes',
      'Porciones',
      'Clasificación',
      'Propiedades nutricionales',
      'Recetas sugeridas',
      'Conservación y sustituciones',
      'Probabilidades de reconocimiento',
      'Estado del ingrediente'
    ];

    for (final section in sections) {
      for (final title in sectionTitles) {
        if (section.startsWith(title)) {
          result[title] = section.substring(title.length).trim();
          break;
        }
      }
    }

    return result;
  }
}