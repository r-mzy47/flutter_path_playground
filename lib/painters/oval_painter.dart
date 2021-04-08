import 'package:flutter/material.dart';

class OvalPainter extends CustomPainter {
  final Offset p0, p1;

  OvalPainter({
    required this.p0,
    required this.p1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //580*648

    Paint paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    var path;

    paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    path = Path()..addOval(Rect.fromPoints(p0, p1));
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
