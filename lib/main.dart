import 'package:flutter_path_playground/widgets/arc_widget.dart';
import 'package:flutter_path_playground/widgets/conic_widget.dart';
import 'package:flutter_path_playground/widgets/cubic_widget.dart';
import 'package:flutter_path_playground/widgets/line_widget.dart';
import 'package:flutter_path_playground/widgets/oval_widget.dart';
import 'package:flutter_path_playground/widgets/polygon_widget.dart';
import 'package:flutter_path_playground/widgets/quadratic_bezier_widget.dart';
import 'package:flutter_path_playground/widgets/rect_widget.dart';
import 'package:flutter_path_playground/widgets/rrect_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Path PlayGround',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlayGroundHome(),
    );
  }
}

class PlayGroundHome extends StatelessWidget {
  const PlayGroundHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Path PlayGround'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Line"),
              Tab(text: "Quadratic bezier"),
              Tab(text: "Cubic"),
              Tab(text: "Conic"),
              Tab(text: "Arc"),
              Tab(text: "Rect"),
              Tab(text: "RRect"),
              Tab(text: "Oval"),
              Tab(text: "Pylygon"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            LineWidget(
              p0: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2),
              p1: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 4),
            ),
            QudaraticBazierWidget(
              p0: Offset(20, MediaQuery.of(context).size.height / 2),
              p1: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 4),
              p2: Offset(MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 2),
            ),
            CubicWidget(
              p0: Offset(20, MediaQuery.of(context).size.height / 3),
              p1: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 3 - 100),
              p2: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 3 + 100),
              p3: Offset(MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 3),
            ),
            ConicWidget(
              p0: Offset(20, MediaQuery.of(context).size.height / 2),
              p1: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 4),
              p2: Offset(MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 2),
            ),
            ArcWidget(
              p0: Offset(MediaQuery.of(context).size.width / 4,
                  MediaQuery.of(context).size.height / 3),
              p1: Offset(MediaQuery.of(context).size.width / 4 * 3,
                  MediaQuery.of(context).size.height / 2),
            ),
            RectWidget(
              p0: Offset(MediaQuery.of(context).size.width / 4,
                  MediaQuery.of(context).size.height / 3),
              p1: Offset(MediaQuery.of(context).size.width / 4 * 3,
                  MediaQuery.of(context).size.height / 2),
            ),
            RRectWidget(
              p0: Offset(MediaQuery.of(context).size.width / 4,
                  MediaQuery.of(context).size.height / 3),
              p1: Offset(MediaQuery.of(context).size.width / 4 * 3,
                  MediaQuery.of(context).size.height / 2),
            ),
            OvalWidget(
              p0: Offset(MediaQuery.of(context).size.width / 4,
                  MediaQuery.of(context).size.height / 3),
              p1: Offset(MediaQuery.of(context).size.width / 4 * 3,
                  MediaQuery.of(context).size.height / 2),
            ),
            PolygonWidget(
                p0: Offset(20, MediaQuery.of(context).size.height / 2),
                p1: Offset(MediaQuery.of(context).size.width / 2,
                    MediaQuery.of(context).size.height / 4),
                p2: Offset(MediaQuery.of(context).size.width - 20,
                    MediaQuery.of(context).size.height / 2)),
          ],
        ),
      ),
    );
  }
}
