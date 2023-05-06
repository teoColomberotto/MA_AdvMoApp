import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';

class MyAboutTitle extends StatelessWidget {
  const MyAboutTitle({super.key});

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
    return Column(
      children: [
        Text('How to Play ?',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text("First rule of quiz club, don't panic",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }

  Widget _buildMobileLanscapeLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How to \nPlay ?',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        const Spacer(),
        Text("First rule of quiz club,\ndon't panic",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        const Spacer(),
      ],
    );
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return Column(
      children: [
        Text('How to Play ?',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text("First rule of quiz club, don't panic",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How to \nPlay ?',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text("First rule of quiz club,\ndon't panic",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }
}
