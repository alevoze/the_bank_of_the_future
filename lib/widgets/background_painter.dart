import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:the_bank_of_the_future/utils/style.dart';

class BackGroundPainter extends CustomPainter{

  BackGroundPainter({Animation<double>animation})
    //   : bluePaint = Paint()
    // ..color = primaryColorStyle
    // ..style = PaintingStyle.fill,
    //     blueWeakPaint = Paint()
    //       ..color = primaryWeakColorStyle
    //       ..style = PaintingStyle.fill,
        :silverPaint = Paint()
          ..color = primaryLightColorStyle
          ..style = PaintingStyle.fill,
        // blueStrongPaint = Paint()
        //   ..color = primaryStrongColorStyle
        //   ..style = PaintingStyle.fill,
        linePaint = Paint()
          ..color = accentColorStyle
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        // blueStrongAnim = CurvedAnimation(
        //   parent: animation,
        //   curve: const Interval(
        //     0,
        //     0.7,
        //     curve: Interval(0, 0.8, curve: SpringCurve()),
        //   ),
        //   reverseCurve: Curves.linear,
        // ),
        silverAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        // blueAnim = CurvedAnimation(
        //   parent: animation,
        //   curve: const Interval(
        //     0,
        //     0.8,
        //     curve: Interval(0, 0.9, curve: SpringCurve()),
        //   ),
        //   reverseCurve: Curves.easeInCirc,
        // ),
        // blueWeakAnim = CurvedAnimation(
        //   parent: animation,
        //   curve: const SpringCurve(),
        //   reverseCurve: Curves.easeInCirc,
        // ),
        super(repaint: animation);


  final Animation<double> liquidAnim;
  // final Animation<double> blueAnim;
  final Animation<double> silverAnim;
  // final Animation<double> blueWeakAnim;
  // final Animation<double> blueStrongAnim;

  final Paint linePaint;
  // final Paint bluePaint;
  final Paint silverPaint;
  // final Paint blueWeakPaint;
  // final Paint blueStrongPaint;

  void _addPointsToPath(Path path, List<Point> points){
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }


  @override
  void paint(Canvas canvas, Size size) {
    paintSilver(size, canvas);
    // paintStrongBlue(size, canvas);
    // paintBlue(size,canvas);
    // paintWeakBlue(size, canvas);


  }

  // void paintBlue(Size size, Canvas canvas){
  //   final path = Path();
  //   path.moveTo(size.width, size.height / 2);
  //   path.lineTo(size.width, 0);
  //   path.lineTo(0, 0);
  //   path.lineTo(0,
  //       lerpDouble(0, size.height, blueAnim.value)
  //   );
  //
  //   // path.quadraticBezierTo(size.width/2, 0, size.width, size.height/2);
  //   _addPointsToPath(path, [
  //
  //     Point(
  //       lerpDouble(0, size.width / 3, blueAnim.value),
  //       lerpDouble(0, size.height, blueAnim.value),
  //     ),
  //
  //     Point(
  //       lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
  //       lerpDouble(size.width / 2, size.height / 4 * 3, liquidAnim.value),
  //     ),
  //
  //     Point(
  //       size.width,
  //       lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
  //     ),
  //
  //   ]);
  //
  //   canvas.drawPath(path, bluePaint);
  // }

  // void paintSilver(Canvas canvas, Size size){
  //   paintSilver(canvas, size);
  // }

  // void paintStrongBlue(Size size, Canvas canvas) {
  //   final path = Path();
  //   path.moveTo(size.width, 300);
  //   path.lineTo(size.width, 0);
  //   path.lineTo(0, 0);
  //   path.lineTo(
  //     0,
  //     lerpDouble(
  //       size.height / 4,
  //       size.height / 2,
  //       blueStrongAnim.value,
  //     ),
  //   );
  //   _addPointsToPath(
  //     path,
  //     [
  //       Point(
  //         size.width / 4,
  //         lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
  //       ),
  //       Point(
  //         size.width * 3 / 5,
  //         lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
  //       ),
  //       Point(
  //         size.width * 4 / 5,
  //         lerpDouble(size.height / 6, size.height / 3, blueStrongAnim.value),
  //       ),
  //       Point(
  //         size.width,
  //         lerpDouble(size.height / 5, size.height / 4, blueStrongAnim.value),
  //       ),
  //     ],
  //   );
  //
  //   canvas.drawPath(path, blueStrongPaint);
  // }

  void paintSilver(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    // path.moveTo(300, size.width);
    path.lineTo(size.width, 0);
    // path.lineTo(0,size.width);
    path.lineTo(0, 0);

    path.lineTo(0,
      lerpDouble(size.height / 1.5, size.height * 3 / 4, liquidAnim.value),
    );
    // path.lineTo(0,
    //   lerpDouble(size.height / 1.5, size.height * 3 / 4, liquidAnim.value),
    // );

    // path.quadraticBezierTo(size.width * 0.6, size.height, size.width / 0.26, size.height / 65);

    // path.moveTo(0, size.height * 0.195);
    // // path.quadraticBezierTo(size.width * 0.155, size.height * 0.11,
    //     size.width * 0.65, size.height * 0.2);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 6);
    // path.quadraticBezierTo(size.width / 22, size.height, size.width, size.height / 2);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    // path.lineTo(
    //   lerpDouble(
    //     size.height / 4,
    //     size.height / 2,
    //     silverAnim.value,
    //   ),
    //   0,
    // );
    _addPointsToPath(
      path,
      [
        // Point(
        //   size.width / 0.1,
        //   lerpDouble(size.height / 60, size.height * 0.5 / 6, liquidAnim.value),
        // ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 45, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, silverAnim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.height / 6, size.height / 6, silverAnim.value),
        ),
      ],
    );

    canvas.drawPath(path, silverPaint);
  }

  // void paintWeakBlue(Size size, Canvas canvas) {
  //   if (blueWeakAnim.value > 0) {
  //     final path = Path();
  //
  //     path.moveTo(size.width * 3 / 4, 0);
  //     path.lineTo(0, 0);
  //     path.lineTo(
  //       0,
  //       lerpDouble(0, size.height / 12, blueWeakAnim.value),
  //     );
  //
  //     _addPointsToPath(path, [
  //       Point(
  //         size.width / 7,
  //         lerpDouble(0, size.height / 6, liquidAnim.value),
  //       ),
  //       Point(
  //         size.width / 3,
  //         lerpDouble(0, size.height / 10, liquidAnim.value),
  //       ),
  //       Point(
  //         size.width / 3 * 2,
  //         lerpDouble(0, size.height / 8, liquidAnim.value),
  //       ),
  //       Point(
  //         size.width * 3 / 4,
  //         0,
  //       ),
  //     ]);
  //
  //     canvas.drawPath(path, blueWeakPaint);
  //   }
  // }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  

}

class Point{
  final double x;
  final double y;

  Point(this.x, this.y);
}

/// Custom curve to give gooey spring effect
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}