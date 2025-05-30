import 'package:flutter/material.dart';

enum NodeShape { circle, robot, book, person }

class ShapePainter extends CustomPainter {
  final Color color;
  final NodeShape shape;

  ShapePainter({required this.color, required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
            case NodeShape.circle:
        // Cámara (más grande y centrada)
        final paint = Paint()..color = Colors.black87;

        // Cuerpo de la cámara (más alto y ancho)
        final body = Rect.fromLTWH(
          size.width * 0.1,
          size.height * 0.25,
          size.width * 0.8,
          size.height * 0.5,
        );
        canvas.drawRRect(RRect.fromRectAndRadius(body, Radius.circular(12)), paint);

        // Lente (más grande y centrado)
        final lensCenter = Offset(size.width / 2, size.height * 0.5);
        canvas.drawCircle(lensCenter, size.width * 0.2, Paint()..color = Colors.blueGrey.shade700);
        canvas.drawCircle(lensCenter, size.width * 0.1, Paint()..color = Colors.blueAccent.shade100);

        // Flash (ligeramente movido para que no quede al borde)
        canvas.drawCircle(
          Offset(size.width * 0.22, size.height * 0.32),
          5,
          Paint()..color = Colors.white,
        );

        // Visor superior (opcional)
        final visor = Rect.fromLTWH(
          size.width * 0.4,
          size.height * 0.18,
          size.width * 0.2,
          size.height * 0.07,
        );
        canvas.drawRRect(RRect.fromRectAndRadius(visor, Radius.circular(4)), paint);
        break;


      case NodeShape.robot:
        final robotPaint = Paint()..color = Colors.blueGrey;

        final head = Rect.fromLTWH(size.width * 0.25, 0, size.width * 0.5, size.height * 0.3);
        final body = Rect.fromLTWH(size.width * 0.2, size.height * 0.3, size.width * 0.6, size.height * 0.5);
        final leftEye = Offset(size.width * 0.35, size.height * 0.1);
        final rightEye = Offset(size.width * 0.65, size.height * 0.1);

        canvas.drawRect(head, robotPaint);
        canvas.drawRect(body, robotPaint);

        final eyePaint = Paint()..color = Colors.white;
        canvas.drawCircle(leftEye, 5, eyePaint);
        canvas.drawCircle(rightEye, 5, eyePaint);

        final antennaPaint = Paint()
          ..color = Colors.redAccent
          ..strokeWidth = 3;
        canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, -15), antennaPaint);
        canvas.drawCircle(Offset(size.width / 2, -15), 5, antennaPaint);
        break;

              case NodeShape.book:
        // Libro abierto con páginas blancas dentro de cubiertas marrones
        final coverPaint = Paint()..color = Colors.brown.shade400;
        final spinePaint = Paint()..color = Colors.brown.shade800;
        final pagePaint = Paint()..color = Colors.white;

        // Cubiertas externas (izquierda y derecha)
        final leftCover = Rect.fromLTWH(0, 0, size.width * 0.48, size.height);
        final rightCover = Rect.fromLTWH(size.width * 0.52, 0, size.width * 0.48, size.height);
        canvas.drawRect(leftCover, coverPaint);
        canvas.drawRect(rightCover, coverPaint);

        // Lomo central
        final spine = Rect.fromLTWH(size.width * 0.48, 0, size.width * 0.04, size.height);
        canvas.drawRect(spine, spinePaint);

        // Páginas blancas internas
        final leftPage = Rect.fromLTWH(size.width * 0.06, size.height * 0.06, size.width * 0.36, size.height * 0.88);
        final rightPage = Rect.fromLTWH(size.width * 0.58, size.height * 0.06, size.width * 0.36, size.height * 0.88);
        canvas.drawRect(leftPage, pagePaint);
        canvas.drawRect(rightPage, pagePaint);

        // Líneas decorativas (simulan texto)
        final linePaint = Paint()
          ..color = Colors.grey.withOpacity(0.4)
          ..strokeWidth = 1;

        for (double y = 0.15; y < 0.9; y += 0.1) {
          canvas.drawLine(
              Offset(size.width * 0.08, size.height * y),
              Offset(size.width * 0.40, size.height * y),
              linePaint);
          canvas.drawLine(
              Offset(size.width * 0.60, size.height * y),
              Offset(size.width * 0.92, size.height * y),
              linePaint);
        }
        break;


           case NodeShape.person:
        // Silueta de persona estilo "vida activa"
        final bodyPaint = Paint()..color = const Color.fromARGB(255, 23, 2, 33);

        // Cabeza
        canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.15), size.width * 0.08, bodyPaint);

        // Cuerpo
        final bodyPath = Path()
          ..moveTo(size.width * 0.5, size.height * 0.22) // cuello
          ..lineTo(size.width * 0.5, size.height * 0.55); // tronco

        // Brazos en diagonal (tipo en movimiento)
        bodyPath.moveTo(size.width * 0.5, size.height * 0.3);
        bodyPath.lineTo(size.width * 0.25, size.height * 0.45);
        bodyPath.moveTo(size.width * 0.5, size.height * 0.3);
        bodyPath.lineTo(size.width * 0.75, size.height * 0.45);

        // Piernas abiertas
        bodyPath.moveTo(size.width * 0.5, size.height * 0.55);
        bodyPath.lineTo(size.width * 0.3, size.height * 0.9);
        bodyPath.moveTo(size.width * 0.5, size.height * 0.55);
        bodyPath.lineTo(size.width * 0.7, size.height * 0.9);

        final strokePaint = Paint()
          ..color = const Color.fromARGB(255, 120, 21, 166)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

        canvas.drawPath(bodyPath, strokePaint);
        break;


    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
