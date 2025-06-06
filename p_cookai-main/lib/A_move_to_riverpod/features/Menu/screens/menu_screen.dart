import 'package:flutter/material.dart';
import '../widgets/plate_painter.dart';
import '../widgets/TableBackgroundPainter.dart';
import '../widgets/circle_node.dart';
import '../widgets/custom_shapes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: TableBackgroundPainter(),
        child: Stack(
          children: [
            // Plato central
            Center(
              child: CustomPaint(
                size: const Size(200, 200),
                painter: PlatePainter(),
              ),
            ),

            // Nodos interactivos
            CircleNode(
              color: Colors.green,
              label: 'B', // Diabetes → ya llama al nuevo DiabeticPredictionForm
              alignment: const Alignment(-0.8, -0.8),
              shape: NodeShape.robot,
            ),
            CircleNode(
              color: Colors.orange,
              label: 'D', // BMI
              alignment: const Alignment(0.8, -0.8),
              shape: NodeShape.book,
            ),
            CircleNode(
              color: Colors.blue,
              label: 'A', // Home
              alignment: const Alignment(-0.8, 0.8),
              shape: NodeShape.person,
            ),
            CircleNode(
              color: Colors.red,
              label: 'C', // Historial
              alignment: const Alignment(0.8, 0.8),
              shape: NodeShape.circle,
            ),
          ],
        ),
      ),
    );
  }
}
