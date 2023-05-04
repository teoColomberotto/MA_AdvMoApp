import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      MyDeviceType myDeviceType =
          getDeviceTypeFromMediaQuery(MediaQuery.of(context));
      if (myDeviceType == MyDeviceType.tabletPortrait) {
        return _buildTabletPortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletLandscape) {
        return _buildTabletLandscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.desktopPortrait) {
        return _buildDesktopPortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.desktopLandscape) {
        return _buildDesktopLandscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.mobilePortrait) {
        return _buildMobilePortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.mobileLandscape) {
        return _buildMobileLandscapeLayout(context);
      } else {
        return const Center(child: Text('Unknown device type'));
      }
    });
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
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
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
                scale: 1,
                opacity: 0.2,
                image: AssetImage('assets/images/pikachu-boxShadow.png'),
                fit: BoxFit.fitHeight),
          ),
        ),
      ]),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
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
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
                scale: 1,
                opacity: 0.2,
                image: AssetImage('assets/images/pikachu-boxShadow.png'),
                fit: BoxFit.fitHeight),
          ),
        ),
      ]),
    );
  }

  Widget _buildDesktopPortraitLayout(BuildContext context) {
    return const Text('Desktop Portrait Layout');
  }

  Widget _buildDesktopLandscapeLayout(BuildContext context) {
    return const Text('Desktop Landscape Layout');
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
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

  Widget _buildMobileLandscapeLayout(BuildContext context) {
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
