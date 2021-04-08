import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset p0, p1;
  LinePainter(this.p0, this.p1);

  @override
  void paint(Canvas canvas, Size size) {
    //580*648

    Paint paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    var path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..relativeLineTo(p1.dx - p0.dx, p1.dy - p0.dy);
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
