import 'package:flutter/material.dart';

class QuadraticBezierPainter extends CustomPainter {
  final Offset p0, p1, p2;
  final double animationValue;
  QuadraticBezierPainter(this.p0, this.p1, this.p2, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    //580*648

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.lightBlue
      ..isAntiAlias = true;

    var path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..relativeQuadraticBezierTo(p1.dx - p0.dx, p1.dy - p0.dy, p2.dx - p0.dx, p2.dy - p0.dy);
    canvas.drawPath(path, paint);
    paint.color = Colors.grey;
    paint.strokeWidth = 2;
    canvas.drawLine(p0, p1, paint);
    canvas.drawLine(p2, p1, paint);
    Offset start = Offset(p0.dx + (p1.dx - p0.dx) * animationValue,
        p0.dy + (p1.dy - p0.dy) * animationValue);
    Offset end = Offset(p1.dx + (p2.dx - p1.dx) * animationValue,
        p1.dy + (p2.dy - p1.dy) * animationValue);
    paint.color = Colors.green;
    canvas.drawLine(start, end, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
