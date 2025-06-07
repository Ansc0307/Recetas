import 'package:flutter/material.dart';
import '../../diabetes/screens/diabetes_form_screen.dart';
import '../../menu/widgets/custom_shapes.dart';
import '../../bmi/presentation/bmi_screen.dart';

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
        destination = DiabetesFormScreen();
        break;
      case 'D':
      destination = BmiScreen();
      break;
        // TODO: Agrega tu pantalla de BMI aquí
        return;
      case 'A':
        // TODO: Agrega tu pantalla de Home aquí
        return;
      case 'C':
        // TODO: Agrega tu pantalla de Historial aquí
        return;
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
          child: const SizedBox(
            width: 75,
            height: 75,
          ),
        ),
      ),
    );
  }
}
