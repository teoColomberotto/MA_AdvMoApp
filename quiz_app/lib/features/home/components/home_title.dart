import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';

class MyAppTitle extends StatelessWidget {
  const MyAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (myDeviceType == MyDeviceType.tabletPortrait ||
          myDeviceType == MyDeviceType.tabletLandscape) {
        return _buildTabletLayout(context);
      } else if (myDeviceType == MyDeviceType.desktopPortrait ||
          myDeviceType == MyDeviceType.desktopLandscape) {
        return _buildDesktopLayout(context);
      } else if (myDeviceType == MyDeviceType.mobilePortrait ||
          myDeviceType == MyDeviceType.mobileLandscape) {
        return _buildMobileLayout(context);
      } else {
        return const Center(child: Text('Unknown device type'));
      }
    });
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Text('Pokemon Quiz',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text('gotta find em all !',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Text('Pokemon Quiz',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text('gotta find em all !',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Text('Pokemon Quiz',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text('gotta find em all !',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }
}
