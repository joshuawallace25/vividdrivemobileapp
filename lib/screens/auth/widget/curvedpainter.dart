import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue; // Red background color
    Path path = Path();

    // Draw the curve
    path.lineTo(0, size.height - 27); // Adjusted lower-left corner height
    path.quadraticBezierTo(
      size.width / 4, // Control point X
      size.height - 40, // Control point Y (height)
      size.width, // End point X
      size.height - 80, // End point Y (height)
    );
    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Close the path

    // Draw the path on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
