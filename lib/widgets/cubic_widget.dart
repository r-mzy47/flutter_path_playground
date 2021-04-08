import 'package:flutter/material.dart';
import 'multi_slider2d.dart';
import '../painters/cubic_painter.dart';

class CubicWidget extends StatefulWidget {
  CubicWidget({
    Key? key,
    required this.p0,
    required this.p1,
    required this.p2,
    required this.p3,
  }) : super(key: key);
  final Offset p0, p1, p2, p3;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CubicWidget>
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
        widget.p3,
      ],
    );
    controller =
        AnimationController(duration: Duration(milliseconds: 1300), vsync: this)
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
                    painter: CubicPainter(
                      thumbsOffset[0],
                      thumbsOffset[1],
                      thumbsOffset[2],
                      thumbsOffset[3],
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
                "var path = Path()..moveTo(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)})..relativeCubicTo(${(thumbsOffset[1].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[1].dy - thumbsOffset[0].dy).toStringAsFixed(1)}, ${(thumbsOffset[2].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[2].dy - thumbsOffset[0].dy).toStringAsFixed(1)}, ${(thumbsOffset[3].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[3].dy - thumbsOffset[0].dy).toStringAsFixed(1)}););"),
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
