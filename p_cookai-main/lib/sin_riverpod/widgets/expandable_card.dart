import 'package:flutter/material.dart';

class ExpandableCard extends StatelessWidget {
  final String title;
  final String body;
  final Color color;
  final IconData icon;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  }) : super(key: key);

  List<TextSpan> parseBoldText(String text) {
    // Divide el texto en fragmentos que estén o no entre ** **
    final regex = RegExp(r'\*\*(.+?)\*\*');
    final spans = <TextSpan>[];

    int start = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > start) {
        // Texto normal antes del **
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      // Texto en negrita (sin los **)
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      start = match.end;
    }
    // Texto después del último **
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: color,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth - 24;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      children: parseBoldText(body.trim()),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
