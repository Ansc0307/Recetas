import 'package:flutter/material.dart';

enum NodeShape { circle, triangle, diamond, hexagon }

class ShapePainter extends CustomPainter {
  final Color color;
  final NodeShape shape;

  ShapePainter({required this.color, required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(colors: [Colors.white, color])
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    switch (shape) {
      case NodeShape.circle:
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
        return;
      case NodeShape.triangle:
        path.moveTo(size.width / 2, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.close();
        break;
      case NodeShape.diamond:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(0, size.height / 2);
        path.close();
        break;
      case NodeShape.hexagon:
        final double w = size.width;
        final double h = size.height;
        path.moveTo(w * 0.5, 0);
        path.lineTo(w, h * 0.25);
        path.lineTo(w, h * 0.75);
        path.lineTo(w * 0.5, h);
        path.lineTo(0, h * 0.75);
        path.lineTo(0, h * 0.25);
        path.close();
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
