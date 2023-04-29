import 'package:flutter/material.dart';

class MyQuizActionsBackground extends StatelessWidget {
  final Color backgroundColor;
  const MyQuizActionsBackground({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: CustomPaint(
        painter: ActionsBackgroundShape(backgroundColor),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: 600,
        ),
      ),
    );
  }
}

class ActionsBackgroundShape extends CustomPainter {
  final Color backgroundColor;
  ActionsBackgroundShape(this.backgroundColor);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.20)
      ..conicTo(
          0, size.height * 0.15, size.width * 0.05, size.height * 0.15, 0.3)
      ..conicTo(size.width * 0.5, 0, size.width * 0.95, size.height * 0.15, 0.5)
      ..conicTo(
          size.width, size.height * 0.15, size.width, size.height * 0.20, 0.3)
      ..lineTo(size.width, size.height * 0.15)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
