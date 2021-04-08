import 'package:flutter/material.dart';

typedef OnPositionChange(Offset offset, int index);

class MulitSlider2D extends StatefulWidget {
  final List<Offset> offset;
  final OnPositionChange onChange;
  final Widget? thumbWidget;
  final double thumbSize;
  const MulitSlider2D({
    Key? key,
    required this.offset,
    required this.onChange,
    this.thumbWidget,
    required this.thumbSize,
  }) : super(key: key);

  @override
  _MulitSlider2DState createState() => _MulitSlider2DState();
}

class _MulitSlider2DState extends State<MulitSlider2D> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (conetxt, constraints) {
      return GestureDetector(
        onPanUpdate: (detais) {
          double x = detais.localPosition.dx;
          double y = detais.localPosition.dy;
          if (x < 0) x = 0;
          if (y < 0) y = 0;
          if (x > constraints.maxWidth) x = constraints.maxWidth;
          if (y > constraints.maxHeight) y = constraints.maxHeight;

          double minDir = 1000;
          int selectedIndex = 0;
          int i = 0;
          widget.offset.forEach((element) {
            if ((element.dy - y).abs() + (element.dx - x).abs() < minDir) {
              minDir = (element.dy - y).abs() + (element.dx - x).abs();
              selectedIndex = i;
            }
            i = i + 1;
          });
          widget.onChange(Offset(x, y), selectedIndex);
        },
        child: Container(
          child: Stack(
            children: [
              Container(),
              ...widget.offset
                  .map(
                    (e) => AnimatedPositioned(
                      duration: Duration(milliseconds: 5),
                      left: e.dx - widget.thumbSize / 2,
                      top: e.dy - widget.thumbSize / 2,
                      child: Column(
                        children: [
                          widget.thumbWidget ??
                              Container(
                                width: widget.thumbSize,
                                height: widget.thumbSize,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        width: 3, color: Colors.black),
                                    shape: BoxShape.circle),
                              ),
                          Text("p${widget.offset.indexOf(e)}"),
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      );
    });
  }
}
