import 'package:flutter/material.dart';

class RRectPainter extends CustomPainter {
  final Offset p0, p1;
  final double topLeft, topRight, bottomRight, bottomLeft;
  RRectPainter({
    required this.p0,
    required this.p1,
    required this.bottomLeft,
    required this.bottomRight,
    required this.topLeft,
    required this.topRight,
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

    path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromPoints(p0, p1),
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
      );
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
