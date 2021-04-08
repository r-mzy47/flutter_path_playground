import 'dart:math';
import '../painters/polygon_painter.dart';
import 'package:flutter/material.dart';
import 'multi_slider2d.dart';

class PolygonWidget extends StatefulWidget {
  PolygonWidget({
    Key? key,
    required this.p0,
    required this.p1,
    required this.p2,
  }) : super(key: key);
  final Offset p0, p1, p2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PolygonWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;

  @override
  void initState() {
    thumbsOffset = List<Offset>.from(
      [widget.p0, widget.p1, widget.p2],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String offsetString = "[";
    thumbsOffset.forEach((element) {offsetString += "Offset(${element.dx.toStringAsFixed(1)}, ${element.dy.toStringAsFixed(1)}),";});
    offsetString += "]";
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: CustomPaint(
              painter: PolygonPainter(
                offsetList: thumbsOffset,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: constraints.maxWidth / 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var rng = new Random();
                      double width = rng.nextDouble() * constraints.maxWidth;
                      double heigh = rng.nextDouble() * constraints.maxHeight;
                      setState(() {
                        thumbsOffset.add(Offset(width, heigh));
                      });
                    },
                    child: Text("add point"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        thumbsOffset = List<Offset>.from(
                          [widget.p0, widget.p1, widget.p2],
                        );
                      });
                    },
                    child: Text("reset"),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "var path = Path()..addPolygon(" + offsetString + ", true);"),
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
    });
  }
}
