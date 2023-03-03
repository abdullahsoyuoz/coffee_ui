import 'dart:ui';

import 'package:coffee_app/View/Style/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundPainter extends CustomPainter {
  BackgroundPainter(this.animation, this.index) : super(repaint: animation) {
    curve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeIn,
    );
  }
  late Animation<double> animation;
  late Animation curve;
  late int index;

  @override
  void paint(Canvas canvas, Size size) {
    paintBottom(canvas, size);
  }

  void paintBottom(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(lerpDouble(size.width * 0.65, 0, curve.value)!, lerpDouble(size.height * 0.9, size.height, animation.value)!);
    path.lineTo(lerpDouble(size.width * 0.1, 0, curve.value)!,lerpDouble(size.height * 0.25 + 50, 0, curve.value)!);
    path.lineTo(lerpDouble(size.width * 0.9, size.width, curve.value)!,lerpDouble(size.height * 0.1, 0, curve.value)!);
    path.lineTo(lerpDouble(size.width * 0.65, size.width, curve.value)!, lerpDouble(size.height * 0.9, size.height, animation.value)!);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = Color.lerp(
              SyzColors.orangeS1.withOpacity(0.4), SyzColors.blackS3, curve.value)!
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
