import 'package:flutter/material.dart';
import 'multi_slider2d.dart';
import '../painters/quadratic_bezier_painter.dart';

class QudaraticBazierWidget extends StatefulWidget {
  QudaraticBazierWidget({
    Key? key,
    required this.p0,
    required this.p1,
    required this.p2,
  }) : super(key: key);
  final Offset p0, p1, p2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<QudaraticBazierWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;

  late AnimationController controller;

  @override
  void initState() {
    thumbsOffset = List<Offset>.from(
      [
        widget.p0,
        widget.p1,
        widget.p2,
      ],
    );
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: QuadraticBezierPainter(
                      thumbsOffset[0],
                      thumbsOffset[1],
                      thumbsOffset[2],
                      controller.value,
                    ),
                  );
                },
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "var path = Path()..moveTo(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)})..relativeQuadraticBezierTo(${(thumbsOffset[1].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[1].dy - thumbsOffset[0].dy).toStringAsFixed(1)}, ${(thumbsOffset[2].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[2].dy - thumbsOffset[0].dy).toStringAsFixed(1)});"),
          ),
        ),
        MulitSlider2D(
          offset: thumbsOffset,
          onChange: (offset, index) {
            setState(() {
              thumbsOffset[index] = offset;
            });
          },
          thumbSize: 16,
        ),
      ],
    );
  }
}
