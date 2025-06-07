import 'package:flutter/material.dart';

class PlatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final plateRadius = size.width * 0.4;

    final platePaint = Paint()..color = Colors.grey.shade300;
    final shadowPaint = Paint()..color = Colors.grey.shade400;
    final utensilPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;

    // Draw plate and inner shadow
    canvas.drawCircle(center, plateRadius, platePaint);
    canvas.drawCircle(center, plateRadius * 0.7, shadowPaint);

    // ---- Fork using Path ----
    final forkPath = Path();
    final forkX = size.width * 0.15;
    final forkTop = size.height * 0.25;
    final forkBottom = size.height * 0.75;
    const prongWidth = 3.0;
    const prongSpacing = 5.0;

    // Prongs (3)
    for (int i = 0; i < 3; i++) {
      double x = forkX + i * (prongWidth + prongSpacing);
      forkPath.addRect(Rect.fromLTWH(x, forkTop, prongWidth, 20));
    }

    // Connect bottom of side prongs with a horizontal line
    final prongBaseY = forkTop + 20;
    final leftX = forkX;
    final rightX = forkX + 2 * (prongWidth + prongSpacing) + prongWidth;
    forkPath.addRect(Rect.fromLTWH(leftX, prongBaseY - 1, rightX - leftX, 2));

    // Slim Handle (aligned with center prong)
    double centerProngX = forkX + (prongWidth + prongSpacing);
    forkPath.addRect(
      Rect.fromLTWH(centerProngX, prongBaseY, prongWidth, forkBottom - prongBaseY),
    );

    canvas.drawPath(forkPath, utensilPaint);

    // ---- Knife using Path ----
    final knifeX = size.width * 0.75; // ← Moved knife closer to center
    final knifeTop = size.height * 0.25;
    final knifeBottom = size.height * 0.75;

    final knifePath = Path();

    // Blade: triangular shape
    knifePath.moveTo(knifeX, knifeTop);
    knifePath.lineTo(knifeX + 6, (knifeTop + knifeBottom) / 2);
    knifePath.lineTo(knifeX, knifeBottom - 20);
    knifePath.close();
    canvas.drawPath(knifePath, utensilPaint);

    // Handle: rectangle under blade
    knifePath.reset();
    knifePath.addRect(Rect.fromLTWH(knifeX - 1.5, knifeBottom - 20, 3, 20));
    canvas.drawPath(knifePath, utensilPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
