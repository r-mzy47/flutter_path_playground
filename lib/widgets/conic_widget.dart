import '../painters/conic_painter.dart';
import 'package:flutter/material.dart';
import 'multi_slider2d.dart';
import 'dart:math' as math;

class ConicWidget extends StatefulWidget {
  ConicWidget({
    Key? key,
    required this.p0,
    required this.p1,
    required this.p2,
  }) : super(key: key);
  final Offset p0, p1, p2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ConicWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;

  late AnimationController controller;
  double w = 1;

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
                    painter: ConicPainter(
                      thumbsOffset[0],
                      thumbsOffset[1],
                      thumbsOffset[2],
                      math.pow(w, 2).toDouble(),
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
                "var path = Path()..moveTo(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)})..relativeConicTo(${(thumbsOffset[1].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[1].dy - thumbsOffset[0].dy).toStringAsFixed(1)}, ${(thumbsOffset[2].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[2].dy - thumbsOffset[0].dy).toStringAsFixed(1)}, ${math.pow(w, 2).toDouble().toStringAsFixed(2)});"),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("w: "),
                Slider(
                  value: w,
                  onChanged: (v) {
                    setState(() {
                      w = v;
                    });
                  },
                  max: 5,
                  min: 0,
                ),
              ],
            ),
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
