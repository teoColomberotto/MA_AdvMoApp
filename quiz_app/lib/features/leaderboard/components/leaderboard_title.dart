import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';

class MyLeaderboardTitle extends StatelessWidget {
  const MyLeaderboardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (myDeviceType == MyDeviceType.mobileLandscape) {
        return _buildMobileLanscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletPortrait) {
        return _buildTabletPortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletLandscape) {
        return _buildTabletLandscapeLayout(context);
      } else {
        return _defaultLayout(context);
      }
    });
  }

  Widget _defaultLayout(BuildContext context) {
    return const Text('Leaderboard',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: Color(0xFFFDE476),
        ));
  }

  Widget _buildMobileLanscapeLayout(BuildContext context) {
    return const Text('Leader\nboard',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: Color(0xFFFDE476),
        ));
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return const Text('Leaderboard',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.w900,
          color: Color(0xFFFDE476),
        ));
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return const Text('Leader\nboard',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.w900,
          color: Color(0xFFFDE476),
        ));
  }
}
