import 'package:flutter/material.dart';

class CubicPainter extends CustomPainter {
  final Offset p0, p1, p2, p3;
  final double animationValue;
  CubicPainter(this.p0, this.p1, this.p2, this.p3, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    //580*648

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.lightBlue
      ..isAntiAlias = true;

    var path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..relativeCubicTo(p1.dx - p0.dx, p1.dy - p0.dy, p2.dx - p0.dx, p2.dy - p0.dy, p3.dx - p0.dx, p3.dy - p0.dy);
    canvas.drawPath(path, paint);
    paint.color = Colors.grey;
    paint.strokeWidth = 2;
    canvas.drawLine(p0, p1, paint);
    canvas.drawLine(p2, p1, paint);
    canvas.drawLine(p2, p3, paint);
    paint.color = Colors.green;
    Offset sl1 = Offset(p0.dx + (p1.dx - p0.dx) * animationValue,
        p0.dy + (p1.dy - p0.dy) * animationValue);
    Offset el1 = Offset(p1.dx + (p2.dx - p1.dx) * animationValue,
        p1.dy + (p2.dy - p1.dy) * animationValue);
    canvas.drawLine(sl1, el1, paint);
    Offset sl2 = Offset(p1.dx + (p2.dx - p1.dx) * animationValue,
        p1.dy + (p2.dy - p1.dy) * animationValue);
    Offset el2 = Offset(p2.dx + (p3.dx - p2.dx) * animationValue,
        p2.dy + (p3.dy - p2.dy) * animationValue);
    canvas.drawLine(sl2, el2, paint);
    paint.color = Colors.red;
    Offset sl3 = Offset(sl1.dx + (el1.dx - sl1.dx) * animationValue,
        sl1.dy + (el1.dy - sl1.dy) * animationValue);
    Offset el3 = Offset(sl2.dx + (el2.dx - sl2.dx) * animationValue,
        sl2.dy + (el2.dy - sl2.dy) * animationValue);
    canvas.drawLine(sl3, el3, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
