import '../painters/arc_painter.dart';
import 'package:flutter/material.dart';
import 'multi_slider2d.dart';
import 'dart:math' as math;

class ArcWidget extends StatefulWidget {
  ArcWidget({
    Key? key,
    required this.p0,
    required this.p1,
  }) : super(key: key);

  final Offset p0, p1;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ArcWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;

  double startAngle = 0, sweepAngle = math.pi;
  bool forceMoveTo = false;
  late Offset p2;

  @override
  void initState() {
    p2 = Offset(widget.p0.dx, widget.p1.dy);
    thumbsOffset = List<Offset>.from(
      [
        widget.p0,
        widget.p1,
        p2,
      ],
    );
    super.initState();
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
              child: CustomPaint(
                painter: ArcPainter(
                  p0: thumbsOffset[0],
                  p1: thumbsOffset[1],
                  startAngle: startAngle,
                  sweepAngle: sweepAngle,
                  p2: forceMoveTo ? null : thumbsOffset[2],
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
                    Text("startAngle:   "),
                    Slider(
                      value: startAngle,
                      onChanged: (v) {
                        setState(() {
                          startAngle = v;
                        });
                      },
                      max: 2 * math.pi,
                      min: 0,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("sweepAngle: "),
                    Slider(
                      value: sweepAngle,
                      onChanged: (v) {
                        setState(() {
                          sweepAngle = v;
                        });
                      },
                      max: 2 * math.pi - 0.00001,
                      min: 0,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text("sweepAngle: "),
                    Center(
                      child: Switch(
                        value: forceMoveTo,
                        onChanged: (v) {
                          setState(
                            () {
                              forceMoveTo = v;
                              if (v == false) {
                                thumbsOffset.add(p2);
                              } else {
                                thumbsOffset.removeLast();
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: forceMoveTo == false
                ? Text(
                    "var path = Path()..moveTo(${thumbsOffset[2].dx.toStringAsFixed(1)}, ${thumbsOffset[2].dy.toStringAsFixed(1)})..arcTo(Rect.fromPoints(Offset(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)}), Offset(${thumbsOffset[1].dx.toStringAsFixed(1)}, ${thumbsOffset[1].dy.toStringAsFixed(1)})), ${startAngle.toStringAsFixed(1)}, ${sweepAngle.toStringAsFixed(1)}, true);")
                : Text(
                    "var path = Path()..arcTo(Rect.fromPoints(Offset(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)}), Offset(${thumbsOffset[1].dx.toStringAsFixed(1)}, ${thumbsOffset[1].dy.toStringAsFixed(1)})), ${startAngle.toStringAsFixed(1)}, ${sweepAngle.toStringAsFixed(1)}, false);"),
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
