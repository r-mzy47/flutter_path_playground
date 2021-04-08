import '../painters/rrect_painter.dart';
import 'package:flutter/material.dart';
import 'multi_slider2d.dart';
import 'dart:math' as math;

class RRectWidget extends StatefulWidget {
  RRectWidget({
    Key? key,
    required this.p0,
    required this.p1,
  }) : super(key: key);
  final Offset p0, p1;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RRectWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;
  double topLeft = 10, topRight = 10, bottomRight = 10, bottomLeft = 10;
  @override
  void initState() {
    thumbsOffset = List<Offset>.from(
      [
        widget.p0,
        widget.p1,
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxRadius = math.min((thumbsOffset[0].dx - thumbsOffset[1].dx).abs(),
        (thumbsOffset[0].dy - thumbsOffset[1].dy).abs());
    topLeft = topLeft > maxRadius ? maxRadius : topLeft;
    topRight = topRight > maxRadius ? maxRadius : topRight;
    bottomRight = bottomRight > maxRadius ? maxRadius : bottomRight;
    bottomLeft = bottomLeft > maxRadius ? maxRadius : bottomLeft;
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: CustomPaint(
                painter: RRectPainter(
                  p0: thumbsOffset[0],
                  p1: thumbsOffset[1],
                  topLeft: topLeft,
                  bottomLeft: bottomLeft,
                  topRight: topRight,
                  bottomRight: bottomRight,
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(

                  children: [
                    Text("topLeft:   "),
                    Slider(
                      value: topLeft,
                      onChanged: (v) {
                        setState(() {
                          topLeft = v;
                        });
                      },
                      max: maxRadius,
                      min: 0,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("topRight: "),
                    Slider(
                      value: topRight,
                      onChanged: (v) {
                        setState(() {
                          topRight = v;
                        });
                      },
                      max: maxRadius,
                      min: 0,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("bottomRight:   "),
                    Slider(
                      value: bottomRight,
                      onChanged: (v) {
                        setState(() {
                          bottomRight = v;
                        });
                      },
                      max: maxRadius,
                      min: 0,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("bottomLeft: "),
                    Slider(
                      value: bottomLeft,
                      onChanged: (v) {
                        setState(() {
                          bottomLeft = v;
                        });
                      },
                      max: maxRadius,
                      min: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("var path = Path()..addRRect(RRect.fromRectAndCorners(Rect.fromPoints(Offset(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)}), Offset(${thumbsOffset[1].dx.toStringAsFixed(1)}, ${thumbsOffset[1].dy.toStringAsFixed(1)})), topLeft: Radius.circular(${topLeft.toStringAsFixed(1)}), topRight: Radius.circular(${topRight.toStringAsFixed(1)}), bottomLeft: Radius.circular(${bottomLeft.toStringAsFixed(1)}), bottomRight: Radius.circular(${bottomRight.toStringAsFixed(1)})));"),
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


