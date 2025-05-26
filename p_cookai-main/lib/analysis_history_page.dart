import 'package:flutter/material.dart';
import 'analysis_history.dart';
import 'history_store.dart';
import 'dart:io';

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
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(entry.imagePath),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),

                    ),
                    title: Text(
                      entry.content.length > 100
                          ? '${entry.content.substring(0, 100)}...'
                          : entry.content,
                    ),
                    subtitle: Text(
                      'Fecha: ${entry.date.day}/${entry.date.month}/${entry.date.year}  ${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}',
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Análisis completo'),
                          content: SingleChildScrollView(child: Text(entry.content)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
