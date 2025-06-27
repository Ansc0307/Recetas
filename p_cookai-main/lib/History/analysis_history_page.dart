import 'package:flutter/material.dart';
import 'history_store.dart';
import 'dart:io';
import 'tts_service.dart';

class AnalysisHistoryPage extends StatelessWidget {
  final bool esPremium;
  const AnalysisHistoryPage({Key? key, required this.esPremium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = HistoryStore.entries.reversed.toList(); // muestra los más recientes primero

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Historial de análisis',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB2EBF2), Color(0xFFD1C4E9)],
          ),
        ),
        child: SafeArea(
          child: entries.isEmpty
              ? const Center(
                  child: Text(
                    'No hay análisis guardados todavía.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(entry.imagePath),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Fecha: ${entry.date.day}/${entry.date.month}/${entry.date.year}  ${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ExpansionTile(
                              title: const Text(
                                'Ver detalles',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              children: [
  ...TextToSpeech()
      .extractSections(entry.content)
      .entries
      .map((entrySection) {
    final tts = TextToSpeech();
    bool isSpeaking = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Card(
          color: Colors.deepPurple.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entrySection.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 6),
                Text(entrySection.value),
                const SizedBox(height: 8),

                // 👉 Condicional según si es premium
                if (esPremium) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.replay, color: Colors.deepPurple),
                        onPressed: () async {
                          await tts.stop();
                          await tts.speak(
                              "${entrySection.key}: ${entrySection.value}");
                          setState(() => isSpeaking = true);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isSpeaking ? Icons.pause : Icons.play_arrow,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () async {
                          if (isSpeaking) {
                            await tts.pause();
                          } else {
                            await tts.speak(
                                "${entrySection.key}: ${entrySection.value}");
                          }
                          setState(() => isSpeaking = !isSpeaking);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop, color: Colors.deepPurple),
                        onPressed: () async {
                          await tts.stop();
                          setState(() => isSpeaking = false);
                        },
                      ),
                    ],
                  ),
                ] else ...[
                  const Text(
                    "🔒 Funcionalidad de voz solo disponible en versión premium.",
                    style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }),
]
,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
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
