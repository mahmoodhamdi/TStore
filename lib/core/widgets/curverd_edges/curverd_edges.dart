import 'package:flutter/material.dart';

class CurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Move to the bottom-left corner
    path.lineTo(0, size.height);

    // Define the control points for the left curve
    final Offset leftCurveControl = Offset(0, size.height - 20);
    final Offset leftCurveEnd = Offset(30, size.height - 20);

    // Draw a curve to create the left curved edge
    path.quadraticBezierTo(
      leftCurveControl.dx,
      leftCurveControl.dy,
      leftCurveEnd.dx,
      leftCurveEnd.dy,
    );

    // Define the control points for the straight line in the middle
    final Offset middleLineStart = Offset(0, size.height - 20);
    final Offset middleLineEnd = Offset(size.width - 30, size.height - 20);

    // Draw a straight line to create the middle straight edge
    path.quadraticBezierTo(
      middleLineStart.dx,
      middleLineStart.dy,
      middleLineEnd.dx,
      middleLineEnd.dy,
    );

    // Define the control points for the right curve
    final Offset rightCurveControl = Offset(size.width, size.height - 20);
    final Offset rightCurveEnd = Offset(size.width, size.height);

    // Draw a curve to create the right curved edge
    path.quadraticBezierTo(
      rightCurveControl.dx,
      rightCurveControl.dy,
      rightCurveEnd.dx,
      rightCurveEnd.dy,
    );

    // Draw a straight line to connect the right curved edge to the bottom-right corner
    path.lineTo(size.width, 0);

    // Close the path to create a closed shape
    path.close();

    // Return the created path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Always return true to force a re-clip when changes are made
    return true;
  }
}
