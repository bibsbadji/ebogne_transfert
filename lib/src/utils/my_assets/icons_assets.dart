import 'package:flutter/material.dart';


class WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, 40, size.width - 40, size.height - 60),
      const Radius.circular(16),
    );

    final flap = RRect.fromRectAndRadius(
      Rect.fromLTWH(40, 20, size.width - 80, 40),
      const Radius.circular(12),
    );

    final button = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width - 60, size.height / 2, 30, 20),
      const Radius.circular(6),
    );

    canvas.drawRRect(body, paint);
    canvas.drawRRect(flap, paint);
    canvas.drawRRect(button, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaperPlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.5)
      ..lineTo(size.width * 0.9, size.height * 0.2)
      ..lineTo(size.width * 0.6, size.height * 0.9)
      ..lineTo(size.width * 0.5, size.height * 0.6)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.6),
      Offset(size.width * 0.65, size.height * 0.45),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.9,
        size.width * 0.2,
        size.height * 0.55,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
