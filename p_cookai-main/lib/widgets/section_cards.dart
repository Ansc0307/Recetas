import 'package:flutter/material.dart';
import 'expandable_card.dart';

class SectionCards extends StatelessWidget {
  final String content;

  const SectionCards({Key? key, required this.content}) : super(key: key);

  @override
Widget build(BuildContext context) {
  final sections = <String, String>{};
  //final regex = RegExp(r'^### (.*?)\s*\n', multiLine: true);
  final regex = RegExp(r'^\s*### (.*?)\s*$', multiLine: true);
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
  if (sections.isEmpty) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            content.trim(),
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }

  final colors = [
    Colors.green.shade50,
    Colors.blue.shade50,
    Colors.red.shade50,
    Colors.orange.shade50,
    Colors.teal.shade50,
    Colors.purple.shade50,
    Colors.cyan.shade50,
  ];

  final icons = [
    Icons.shopping_cart,
    Icons.dinner_dining,
    Icons.favorite,
    Icons.restaurant_menu,
    Icons.lightbulb,
    Icons.swap_horiz,
    Icons.info,
  ];

  int index = 0;
  final cards = sections.entries.map((entry) {
    final color = colors[index % colors.length];
    final icon = icons[index % icons.length];
    index++;

    return ExpandableCard(
      title: entry.key,
      body: entry.value,
      color: color,
      icon: icon,
    );
  }).toList();

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(children: cards),
    ),
  );
}

}
