import 'package:flutter/material.dart';
import '../utils/utils.dart';

class MyColors {
  static Color myWhite = Colors.white;
  static Color myBlack = Colors.black;

  static Color myOrangeAccent = hexToColor('#FF6745');

  static Color myPrimaryColor = Colors.white;
  static Color myOnPrimaryColor = hexToColor('#FF2E01');
  static Color myPrimaryDarkColor = Colors.white;
  static Color myOnPrimaryDarkColor = Colors.white;

  static Color mySecondaryColor = hexToColor('#FFE673');
  static Color mySecondaryDarkColor = hexToColor('#FFE673');
  static Color myOnSecondaryColor = Colors.white;
  static Color myOnSecondaryDarkColor = Colors.white;

  static Color myTertiaryColor = hexToColor('#FFE5E4');
  static Color myTertiaryDarkColor = hexToColor('#FFE5E4');
  static Color myOnTertiaryColor = hexToColor('#FF2E01');
  static Color myOnTertiaryDarkColor = hexToColor('#FF2E01');

  static Color myErrorColor = Colors.red;
  static Color myErrorDarkColor = Colors.red;
  static Color myOnErrorColor = Colors.white;
  static Color myOnErrorDarkColor = Colors.white;

  static Color myBackgroundColor = hexToColor('#FF2E01');
  static Color myBackgroundDarkColor = Colors.white;
  static Color myOnBackgroundColor = hexToColor('#FFE5E4');
  static Color myOnBackgroundDarkColor = Colors.white;

  static Color mySurfaceColor = Colors.white;
  static Color mySurfaceDarkColor = Colors.white;
  static Color myOnSurfaceColor = Colors.white;
  static Color myOnSurfaceDarkColor = Colors.white;
}

class MyColorsGradients {
  static LinearGradient myBackgroundRedGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [hexToColor('#FF2E01'), hexToColor('#FF6745')],
  );
}
