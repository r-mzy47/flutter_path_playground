import 'package:flutter/material.dart';

class PolygonPainter extends CustomPainter {
  final List<Offset> offsetList;

  PolygonPainter({
    required this.offsetList,
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

    path = Path()..addPolygon(offsetList, true);
    canvas.drawPath(path, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
