import 'package:flutter/material.dart';
import 'history_store.dart';
import 'dart:io';
import 'tts_service.dart';
import 'package:cookai_prototype/widgets/section_cards.dart';

class AnalysisHistoryPage extends StatelessWidget {
  const AnalysisHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = HistoryStore.entries.reversed.toList(); // muestra los más recientes primero

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de análisis'),
      ),
      body: entries.isEmpty
          ? const Center(
              child: Text(
                'No hay análisis guardados todavía.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(entry.imagePath),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Fecha: ${entry.date.day}/${entry.date.month}/${entry.date.year}  ${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        //SectionCards(content: entry.content),
        ExpansionTile(
  title: const Text('Ver detalles'),
  children: [
    ...TextToSpeech().extractSections(entry.content).entries.map((entrySection) {
      final tts = TextToSpeech(); // Una nueva instancia por sección
      bool isSpeaking = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entrySection.key,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(entrySection.value),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: () async {
                          await tts.stop();
                          await tts.speak("${entrySection.key}: ${entrySection.value}");
                          setState(() => isSpeaking = true);
                        },
                      ),
                      IconButton(
                        icon: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
                        onPressed: () async {
                          if (isSpeaking) {
                            await tts.pause();
                          } else {
                            await tts.speak("${entrySection.key}: ${entrySection.value}");
                          }
                          setState(() => isSpeaking = !isSpeaking);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: () async {
                          await tts.stop();
                          setState(() => isSpeaking = false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }),
  ],
),

      ],
    ),
  ),
);

              },
            ),
    );
  }
}
Map<String, String> cleanSections(Map<String, String> sections) {
  final Map<String, String> cleaned = {};
  final RegExp pattern = RegExp(r'^(\*+|#+|-+|\s*)');

  for (var entry in sections.entries) {
    final cleanedKey = entry.key.replaceAll(pattern, '').trim();
    final cleanedValue = entry.value.replaceAll(pattern, '').trim();
    cleaned[cleanedKey] = cleanedValue;
  }
  return cleaned;
}
