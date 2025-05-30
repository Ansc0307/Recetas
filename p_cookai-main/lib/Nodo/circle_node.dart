import 'package:flutter/material.dart';
import '../Vista/bmi_screen.dart';
import '../ModelRT/obesity_predictor_form.dart';
import '../home_page.dart';
import '../analysis_history_page.dart';

class CircleNode extends StatelessWidget {
  final Color color;
  final String label;
  final Alignment alignment;

  const CircleNode({
    super.key,
    required this.color,
    required this.label,
    required this.alignment,
  });

  void _navigate(BuildContext context) {
    Widget destination;
    switch (label) {
      case 'A':
        destination = ObesityPredictorForm();
        break;
      case 'B':
        destination = BmiScreen();
        break;
      case 'C':
        destination = HomePage();
        break;
      case 'D':
        destination = AnalysisHistoryPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: () => _navigate(context),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: RadialGradient(colors: [Colors.white, color]),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 45),
            ),
          ),
        ),
      ),
    );
  }
}
