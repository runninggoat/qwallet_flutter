import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Market extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageBody();
  }
}

class PageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClockState(width: 300, bgColor: Colors.yellow[300],),
        ],
      ),
    );
  }
}

class ClockState extends StatefulWidget {
  final double width;
  final Color bgColor;

  ClockState({
    Key key,
    this.width,
    this.bgColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Clock(width: width, bgColor: bgColor);
  }
}

class Clock extends State<ClockState> {
  double width = 200.0;
  Color bgColor;
  List<NumberMark> marks = List();
  List<Dot> dots = List();
  DateTime tick = DateTime.now();
  Timer interval;

  Clock({double width, Color bgColor = Colors.lightGreen}) {
    this.width = width;
    this.bgColor = bgColor;
    for (int i = 1; i <= 12; i++) {
      marks.add(NumberMark(
          width: width, rotation: pi + (pi / 6) * i, label: i.toString()));
    }
    for (int i = 1; i <= 60; i++) {
      dots.add(
        Dot(
          width: width,
          rotation: pi + (pi / 30) * i,
        ),
      );
    }
    print('starting clock...');
    interval = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        tick = DateTime.now();
        // print(tick.toUtc());
      });
    });
  }

  @override
  void dispose() {
    print('stopping clock...');
    interval.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[
      HourArm(
          width: width,
          rotation: pi + (pi / 6 * tick.hour) + (pi / 360 * tick.minute),
          color: Colors.blueGrey),
      MinuteArm(
          width: width,
          rotation: pi + (pi / 30 * tick.minute) + (pi / 1800 * tick.second),
          color: Colors.orange[400]),
      SecondArm(
          width: width,
          rotation: pi + (pi / 30 * tick.second),
          color: Colors.blue[400]),
    ];
    widgets.addAll(dots);
    widgets.addAll(marks);
    widgets.add(PivitalTap(width: width));
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: widgets,
      ),
    );
  }
}

class NumberMark extends StatelessWidget {
  final double width;
  final double rotation;
  final String label;

  NumberMark({
    Key key,
    this.width,
    this.rotation,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        padding: EdgeInsets.only(top: width / 2),
        child: Container(
          width: 20,
          height: width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform.rotate(
                angle: 0 - rotation,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PivitalTap extends StatelessWidget {
  final double width;

  PivitalTap({
    Key key,
    double width,
  }) : this.width = width * 0.1, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double width;
  final double rotation;

  Dot({
    Key key,
    double width,
    this.rotation,
  }) : this.width = width * 0.02, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        padding: EdgeInsets.only(top: width / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(width / 2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SecondArm extends StatelessWidget {
  final double width;
  final double rotation;
  final Color color;

  SecondArm({Key key, double width, this.rotation, this.color})
      : this.width = width * 0.9,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        padding: EdgeInsets.only(top: width / 2),
        child: Container(
          child: Container(
            width: 10,
            height: width / 2,
            child: ClipPath(
              clipper: TriangleClipper(),
              child: CustomPaint(
                painter: TriangleBorderPainter(color:color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MinuteArm extends SecondArm {
  MinuteArm({
    Key key,
    double width,
    double rotation,
    Color color,
  }) : super(key: key, width: width * 0.85, rotation: rotation, color: color);
}

class HourArm extends SecondArm {
  HourArm({
    Key key,
    double width,
    double rotation,
    Color color,
  }) : super(key: key, width: width * 0.65, rotation: rotation, color: color);
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class TriangleBorderPainter extends CustomPainter {
  Color color = Colors.white;

  TriangleBorderPainter({Color color}) : assert(color != null), this.color = color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPaint(fillPaint);
    Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black45;
    Path path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
