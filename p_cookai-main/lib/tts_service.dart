import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speak(String text) async {
    await _tts.setLanguage("es-ES"); // Configura el idioma
    await _tts.setPitch(1.0); // Tono normal (1.0)
    await _tts.setSpeechRate(0.5); // Velocidad moderada
    await _tts.speak(text);
  }

  static Future<void> stop() async => await _tts.stop();
}