import 'package:flutter/material.dart';

class SectionCards extends StatelessWidget {
  final String content;

  const SectionCards({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sections = <String, String>{};

    // Captura encabezados que empiezan con ###
    final regex = RegExp(r'^### (.*?)\s*\n', multiLine: true);
    final matches = regex.allMatches(content);

    for (int i = 0; i < matches.length; i++) {
      final current = matches.elementAt(i);
      final start = current.end;
      final end = (i + 1 < matches.length)
          ? matches.elementAt(i + 1).start
          : content.length;

      final title = current.group(1)!.trim();
      final sectionContent = content.substring(start, end).trim();
      sections[title] = sectionContent;
    }

    Widget buildCard(String title, String body) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📌 $title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(body.trim(), style: TextStyle(fontSize: 16, height: 1.5)),
            ],
          ),
        ),
      );
    }

    List<Widget> cards = [];

    if (sections.containsKey('Identificación de los ingredientes y cantidades aproximadas:')) {
      cards.add(buildCard('Ingredientes y cantidades',
          sections['Identificación de los ingredientes y cantidades aproximadas:']!));
    }

    if (sections.containsKey('Número de porciones y tipo de plato:')) {
      cards.add(buildCard('Porciones y tipo de plato',
          sections['Número de porciones y tipo de plato:']!));
    }

    if (sections.containsKey('Propiedades nutricionales por porción (aproximadas):')) {
      cards.add(buildCard('Propiedades nutricionales',
          sections['Propiedades nutricionales por porción (aproximadas):']!));
    }

    if (sections.containsKey('Recetas sugeridas:')) {
      final recetasRaw = sections['Recetas sugeridas:']!;

      final recetas = recetasRaw
          .replaceAll('\r\n', '\n') // normaliza saltos de línea
          .split(RegExp(r'\n(?=\s*####\s)')) // divide por subtítulos
          .map((e) => e.trim())
          .where((e) => e.startsWith('####'))
          .map((e) {
            final lines = e.split('\n');
            final title = lines.first.replaceFirst(RegExp(r'^####\s*'), '').trim();
            final body = lines.skip(1).join('\n').trim();
            return {'title': title, 'body': body};
          })
          .toList();

      cards.add(Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🍽 Recetas sugeridas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              ...recetas.map((receta) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(receta['title']!,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text(receta['body']!,
                          style: TextStyle(fontSize: 15, height: 1.4)),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ));
    }

    if (sections.containsKey('Consejos de conservación:')) {
      cards.add(buildCard('Consejos de conservación', sections['Consejos de conservación:']!));
    }

    if (sections.containsKey('Variaciones y sustituciones:')) {
      cards.add(buildCard('Variaciones y sustituciones',
          sections['Variaciones y sustituciones:']!));
    }

    return Column(children: cards);
  }
}
