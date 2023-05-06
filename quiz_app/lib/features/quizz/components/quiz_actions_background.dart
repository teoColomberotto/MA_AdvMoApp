import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';

class MyQuizActionsBackground extends StatelessWidget {
  final Color backgroundColor;
  const MyQuizActionsBackground({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(
      builder: (context, constraints) {
        if (myDeviceType == MyDeviceType.mobilePortrait) {
          return _buildMobilePortraitToLayout(context);
        } else if (myDeviceType == MyDeviceType.mobileLandscape) {
          return _buildMobileLandscapeToLayout(context);
        } else if (myDeviceType == MyDeviceType.tabletPortrait) {
          return _buildTabletPortraitToLayout(context);
        } else if (myDeviceType == MyDeviceType.tabletLandscape) {
          return _buildTabletLandscapeToLayout(context);
        } else {
          return _buildMobilePortraitToLayout(context);
        }
      },
    );
  }

  Widget _buildMobilePortraitToLayout(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: CustomPaint(
        painter: ActionsBackgroundShapeMobilePortrait(backgroundColor),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }

  Widget _buildMobileLandscapeToLayout(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Transform.rotate(
        angle: pi / 2,
        child: CustomPaint(
          painter: ActionsBackgroundShapeMobileLandscape(backgroundColor),
          child: SizedBox(
            width: MediaQuery.of(context).size.height - 10,
            height: 400,
          ),
        ),
      ),
    );
  }

  Widget _buildTabletPortraitToLayout(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: CustomPaint(
        painter: ActionsBackgroundShapeMobilePortrait(backgroundColor),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }

  Widget _buildTabletLandscapeToLayout(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: CustomPaint(
        painter: ActionsBackgroundShapeMobilePortrait(backgroundColor),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: 600,
        ),
      ),
    );
  }
}

class ActionsBackgroundShapeMobilePortrait extends CustomPainter {
  final Color backgroundColor;
  ActionsBackgroundShapeMobilePortrait(this.backgroundColor);
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

class ActionsBackgroundShapeMobileLandscape extends CustomPainter {
  final Color backgroundColor;
  ActionsBackgroundShapeMobileLandscape(this.backgroundColor);
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
