import '../painters//line_widget.dart';
import 'package:flutter/material.dart';
import 'multi_slider2d.dart';

class LineWidget extends StatefulWidget {
  LineWidget({
    Key? key,
    required this.p0,
    required this.p1,
  }) : super(key: key);
  final Offset p0, p1;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LineWidget>
    with SingleTickerProviderStateMixin {
  late List<Offset> thumbsOffset;

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
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: CustomPaint(
                painter: LinePainter(
                  thumbsOffset[0],
                  thumbsOffset[1],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "var path = Path()..moveTo(${thumbsOffset[0].dx.toStringAsFixed(1)}, ${thumbsOffset[0].dy.toStringAsFixed(1)})..relativeLineTo(${(thumbsOffset[1].dx - thumbsOffset[0].dx).toStringAsFixed(1)}, ${(thumbsOffset[1].dy - thumbsOffset[0].dy).toStringAsFixed(1)});"),
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
