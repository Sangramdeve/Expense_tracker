
import 'package:flutter/material.dart';

class ChartCircle extends CustomPainter {
  final double outerRadius;
  final double innerRadius;
  final List<int> percent;
  final List<Color> color;

  ChartCircle({
    required this.percent,
    required this.outerRadius,
    required this.innerRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -3.141592653589793 / 2; // Start angle (starting from the top)

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: outerRadius,
    );

    for (int i = 0; i < percent.length; i++) {
      final sweepAngle = 2 * 3.141592653589793 * (percent[i] / 100);

      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 65
        ..color = color[i]; // Use solid color

      // Draw the arc segment
      canvas.drawArc(
        rect,
        startAngle, // Start angle for this segment
        sweepAngle, // Sweep angle (how much of the circle to draw)
        false, // Use center (false for stroke)
        paint,
      );

      // Update the start angle for the next segment
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

