import 'package:flutter/material.dart';
//import '../Vista/bmi_screen.dart';
//import 'package:cookai_prototype/bmi.dart';
import '../screenss/bmi_screen.dart';
//import '../ModelRT/obesity_predictor_form.dart';
//import '../Obesidad/obesity_predictor_form.dart';
//import '../diabetes/diabetes_form_pre.dart';
//import '../../home_page.dart';
import '../Version Premium/analysis_history_page.dart';
import '../Version Premium/home_page.dart';
import 'custom_shapes.dart'; // Archivo nuevo que definiremos abajo

class CircleNode extends StatelessWidget {
  final Color color;
  final String label;
  final Alignment alignment;
  final NodeShape shape;
  

  const CircleNode({
    super.key,
    required this.color,
    required this.label,
    required this.alignment,
    required this.shape,
  });

  void _navigate(BuildContext context) {
    Widget destination;
    switch (label) {
      case 'B':
        //destination = ObesityPredictorForm();
        //destination = DiabeticPredictionForm();
        destination = BmiScreen();
        break;
      case 'D':
        destination = BmiScreen();
        break;
      case 'A':
        destination = HomePage();
        break;
      case 'C':
        destination = AnalysisHistoryPagePrem();
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
        child: CustomPaint(
          painter: ShapePainter(color: color, shape: shape),
          child: SizedBox(
            width: 75,
            height: 75,
            child: Center(
              
            ),
          ),
        ),
      ),
    );
  }
}
