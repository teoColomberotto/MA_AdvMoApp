import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return _buildPortraitLayout(context);
    } else {
      return _buildLandscapeLayout(context);
    }
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment:
                Alignment.center, // Center the image within the crop area
            child: ClipRect(
              child: Image.asset(
                'assets/images/pikachu-logo.png', // Replace with your image path
                fit: BoxFit
                    .cover, // Scale and crop the image to fit the crop area
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              scale: 0.02,
              opacity: 0.2,
              image: AssetImage('assets/images/pikachu-boxShadow.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center, // Center the image within the crop area
        child: ClipRect(
          child: Image.asset(
            'assets/images/pikachu-logo.png', // Replace with your image path
            fit: BoxFit.cover, // Scale and crop the image to fit the crop area
          ),
        ),
      ),
    );
  }
}
