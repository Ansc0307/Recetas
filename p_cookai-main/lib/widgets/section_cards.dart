import 'package:flutter/material.dart';
import 'expandable_card.dart';

class SectionCards extends StatelessWidget {
  String content; // mutable para modificar

  SectionCards({Key? key, required this.content}) : super(key: key);

  // Método para normalizar los títulos como antes
  String normalizeTitles(String text) {
    // Si ya hay títulos con #
    if (text.contains('#')) {
      return text; // Ya está normalizado
    }

    final regexAsteriscos = RegExp(r'\*\*(.+?)\*\*');
    final matches = regexAsteriscos.allMatches(text).toList();

    int count = 0;
    String newText = text;

    for (final match in matches) {
      count++;
      final fullMatch = match.group(0)!; // **titulo**
      final titleText = match.group(1)!; // titulo sin **

      if (count.isOdd) {
        // Reemplazar solo la ocurrencia específica por título ###
        newText = newText.replaceFirst(fullMatch, '### $titleText');
      } else {
        // Remover la ocurrencia par
        newText = newText.replaceFirst(fullMatch, '');
      }
    }

    return newText;
  }

  @override
  Widget build(BuildContext context) {
    final sections = <String, String>{};

    // Normalizar contenido si no tiene ya títulos
    if (!content.contains('#')) {
      content = normalizeTitles(content);
    }

    // Extraemos secciones usando títulos ### 
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

    // Construimos las cards según las secciones encontradas
    final cards = <Widget>[];

    if (sections.containsKey('Identificación de los ingredientes y cantidades aproximadas:') ||
    sections.containsKey('Ingredientes y Cantidades Aproximadas:')) {
  final key = sections.containsKey('Identificación de los ingredientes y cantidades aproximadas:')
      ? 'Identificación de los ingredientes y cantidades aproximadas:'
      : 'Ingredientes y Cantidades Aproximadas:';

  cards.add(ExpandableCard(
    title: 'Ingredientes y cantidades',
    body: sections[key]!,
    color: Colors.green.shade50,
    icon: Icons.shopping_cart,
  ));
}


    if (sections.containsKey('Número de porciones y tipo de plato:') ||
    sections.containsKey('Número de Porciones y Tipo de Plato:')) {
  final key = sections.containsKey('Número de porciones y tipo de plato:')
      ? 'Número de porciones y tipo de plato:'
      : 'Número de Porciones y Tipo de Plato:';

  cards.add(ExpandableCard(
    title: 'Porciones y tipo de plato',
    body: sections[key]!,
    color: Colors.blue.shade50,
    icon: Icons.dinner_dining,
  ));
}

    if (sections.containsKey('Propiedades nutricionales por porción (aproximadas):') ||
    sections.containsKey('Propiedades Nutricionales por Porción:')) {
  final key = sections.containsKey('Propiedades nutricionales por porción (aproximadas):')
      ? 'Propiedades nutricionales por porción (aproximadas):'
      : 'Propiedades Nutricionales por Porción:';

  cards.add(ExpandableCard(
    title: 'Propiedades nutricionales',
    body: sections[key]!,
    color: Colors.red.shade50,
    icon: Icons.favorite,
  ));
}

    if (sections.containsKey('Recetas sugeridas:')) {
      final recetasRaw = sections['Recetas sugeridas:']!;

      final recetas = recetasRaw
          .replaceAll('\r\n', '\n') // normaliza saltos de línea
          .split(RegExp(r'\n(?=\s*####\s)')) // divide por subtítulos ####
          .map((e) => e.trim())
          .where((e) => e.startsWith('####'))
          .map((e) {
            final lines = e.split('\n');
            final title = lines.first.replaceFirst(RegExp(r'^####\s*'), '').trim();
            final body = lines.skip(1).join('\n').trim();
            return {'title': title, 'body': body};
          })
          .toList();

      cards.add(
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          color: Colors.orange.shade50,
          child: ExpansionTile(
            leading: const Icon(Icons.restaurant_menu, color: Colors.black54),
            title: const Text(
              '🍽 Recetas sugeridas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: recetas.map((receta) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(receta['title']!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(receta['body']!, style: const TextStyle(fontSize: 15, height: 1.4)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    if (sections.containsKey('Consejos de conservación:')) {
      cards.add(ExpandableCard(
        title: 'Consejos de conservación',
        body: sections['Consejos de conservación:']!,
        color: Colors.teal.shade50,
        icon: Icons.lightbulb,
      ));
    }

    if (sections.containsKey('Variaciones y sustituciones:')) {
      cards.add(ExpandableCard(
        title: 'Variaciones y sustituciones',
        body: sections['Variaciones y sustituciones:']!,
        color: Colors.purple.shade50,
        icon: Icons.swap_horiz,
      ));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: cards),
      ),
    );
  }
}
