import 'dart:math';
import 'package:flutter/material.dart';

class TableBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Wooden background gradient (unchanged)
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF8B5E3C),
          const Color(0xFF5E3B1A),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawRect(rect, backgroundPaint);

    // Wood plank lines (horizontal)
    final plankPaint = Paint()
      ..color = Colors.brown.shade900.withOpacity(0.1)
      ..strokeWidth = 2;

    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), plankPaint);
    }

    // Wood grain lines (vertical)
    for (double x = 0; x < size.width; x += 80) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        plankPaint..strokeWidth = 1,
      );
    }

    // --- Blue circular tablecloth ---
    final center = Offset(size.width / 2, size.height / 2);
    final clothRadius = size.width * 0.35;

    final clothPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.blue.shade400,
          Colors.blue.shade900,
        ],
        center: Alignment.topLeft,
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: center, radius: clothRadius));

    canvas.drawCircle(center, clothRadius, clothPaint);

    // --- Draping cloth effect (blue shades) ---
    final drapePaint = Paint()
      ..color = Colors.blue.shade900.withOpacity(0.9);

    final drapePath = Path();

    const drapeCount = 8;
    final drapeHeight = clothRadius * 0.5;
    final angleStep = 2 * pi / drapeCount;

    for (int i = 0; i < drapeCount; i++) {
      final startAngle = i * angleStep;
      final nextAngle = (i + 1) * angleStep;
      final midAngle = (startAngle + nextAngle) / 2;

      final p1 = Offset(
        center.dx + clothRadius * cos(startAngle),
        center.dy + clothRadius * sin(startAngle),
      );

      final p2 = Offset(
        center.dx + clothRadius * cos(nextAngle),
        center.dy + clothRadius * sin(nextAngle),
      );

      final bottomPoint = Offset(
        center.dx + (clothRadius + drapeHeight) * cos(midAngle),
        center.dy + (clothRadius + drapeHeight) * sin(midAngle),
      );

      drapePath.moveTo(p1.dx, p1.dy);
      drapePath.quadraticBezierTo(
        bottomPoint.dx,
        bottomPoint.dy,
        p2.dx,
        p2.dy,
      );
    }

    drapePath.close();
    canvas.drawPath(drapePath, drapePaint);

    // --- Draw chairs (purple-blue colors) ---
    final chairPaint = Paint()
      ..shader = LinearGradient(
        colors: [
         Colors.purple.shade700,
      const Color.fromARGB(255, 6, 92, 177),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, clothRadius * 0.7, clothRadius * 0.4));

    // Chair size parameters
   // --- Draw chairs ---

// Chair size parameters
final chairWidth = clothRadius * 0.7;
final chairHeight = clothRadius * 0.4;
final chairLegHeight = chairHeight * 0.3;
final chairBackHeight = chairHeight * 0.6;

// Paint for cushions (seat and back) - purple/blue gradient
final cushionPaint = Paint()
  ..shader = LinearGradient(
    colors: [
      Colors.purple.shade700,
      const Color.fromARGB(255, 6, 92, 177),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(Rect.fromLTWH(0, 0, chairWidth, chairHeight));

// Paint for wooden parts (legs and frame)
final woodPaint = Paint()
  ..color = Colors.brown.shade800
  ..style = PaintingStyle.fill;

// ----- Top chair -----
// Chair center position (top)
final topChairCenter = Offset(center.dx, center.dy - clothRadius - chairHeight - 10);

// Cushion seat rectangle
final topSeatRect = Rect.fromCenter(
  center: Offset(topChairCenter.dx, topChairCenter.dy + chairBackHeight / 2),
  width: chairWidth,
  height: chairHeight - chairBackHeight,
);
canvas.drawRect(topSeatRect, cushionPaint);

// Cushion back rectangle
final topBackRect = Rect.fromLTWH(
  topSeatRect.left,
  topSeatRect.top - chairBackHeight,
  chairWidth,
  chairBackHeight,
);
canvas.drawRect(topBackRect, cushionPaint);

// Chair legs and frame (wood)
final legWidth = chairWidth * 0.15;
final legHeight = chairLegHeight;
final legsOffsetY = topSeatRect.bottom;

// Left front leg
canvas.drawRect(
  Rect.fromLTWH(topSeatRect.left, legsOffsetY, legWidth, legHeight),
  woodPaint,
);

// Right front leg
canvas.drawRect(
  Rect.fromLTWH(topSeatRect.right - legWidth, legsOffsetY, legWidth, legHeight),
  woodPaint,
);

// Left back leg
canvas.drawRect(
  Rect.fromLTWH(topSeatRect.left, topSeatRect.top - legHeight, legWidth, legHeight),
  woodPaint,
);

// Right back leg
canvas.drawRect(
  Rect.fromLTWH(topSeatRect.right - legWidth, topSeatRect.top - legHeight, legWidth, legHeight),
  woodPaint,
);

// ----- Bottom chair -----
// Chair center position (bottom)
final bottomChairCenter = Offset(center.dx, center.dy + clothRadius + chairHeight + 10);

// Cushion seat rectangle
final bottomSeatRect = Rect.fromCenter(
  center: Offset(bottomChairCenter.dx, bottomChairCenter.dy - chairBackHeight / 2),
  width: chairWidth,
  height: chairHeight - chairBackHeight,
);
canvas.drawRect(bottomSeatRect, cushionPaint);

// Cushion back rectangle
final bottomBackRect = Rect.fromLTWH(
  bottomSeatRect.left,
  bottomSeatRect.bottom,
  chairWidth,
  chairBackHeight,
);
canvas.drawRect(bottomBackRect, cushionPaint);

// Chair legs and frame (wood)

// Left front leg
canvas.drawRect(
  Rect.fromLTWH(bottomSeatRect.left, bottomSeatRect.bottom, legWidth, legHeight),
  woodPaint,
);

// Right front leg
canvas.drawRect(
  Rect.fromLTWH(bottomSeatRect.right - legWidth, bottomSeatRect.bottom, legWidth, legHeight),
  woodPaint,
);

// Left back leg
canvas.drawRect(
  Rect.fromLTWH(bottomSeatRect.left, bottomSeatRect.top - legHeight, legWidth, legHeight),
  woodPaint,
);

// Right back leg
canvas.drawRect(
  Rect.fromLTWH(bottomSeatRect.right - legWidth, bottomSeatRect.top - legHeight, legWidth, legHeight),
  woodPaint,
);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
