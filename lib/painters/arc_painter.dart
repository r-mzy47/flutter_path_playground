import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final Offset p0, p1;
  final Offset? p2;
  final double startAngle, sweepAngle;
  ArcPainter({
    required this.p0,
    required this.p1,
    required this.startAngle,
    required this.sweepAngle,
    this.p2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //580*648

    Paint paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    var path;
    if (p2 != null) {
      path = Path()
        ..moveTo(p2!.dx, p2!.dy)
        ..arcTo(Rect.fromPoints(p0, p1), startAngle, sweepAngle, false);
    }
    else
      path = Path()
        ..arcTo(Rect.fromPoints(p0, p1), startAngle, sweepAngle, true);
    canvas.drawPath(path, paint);

    paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    path = Path()..addRect(Rect.fromPoints(p0, p1));
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
