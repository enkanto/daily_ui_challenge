import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotatingPolygonScreen extends StatefulWidget {
  const RotatingPolygonScreen({Key? key}) : super(key: key);

  @override
  State<RotatingPolygonScreen> createState() => _RotatingPolygonScreenState();
}

class _RotatingPolygonScreenState extends State<RotatingPolygonScreen> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          painter: _PolygonPainter(),
        ),
      ),
    );
  }
}

class _PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final polygon = Polygon(
      x: size.width / 2,
      y: size.height / 2,
      radius: 150,
      sides: 3,
    );

    final path = polygon.createPath(canvas);
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Polygon {
  final double x;
  final double y;
  final double radius;
  final int sides;

  double rotate = 0;

  Polygon({
    required this.x,
    required this.y,
    required this.radius,
    required this.sides,
  });

  Path createPath(Canvas canvas) {
    final path = Path();
    final angle = 2 * math.pi / sides;
    path.moveTo(radius * math.cos(0), radius * math.sin(0));
    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(angle * i);
      double y = radius * math.sin(angle * i);
      path.lineTo(x, y);
    }
    path.close();

    return path;
  }
}
