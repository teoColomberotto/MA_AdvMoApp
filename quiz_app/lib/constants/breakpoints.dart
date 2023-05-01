class MyBreakpoints {
  static double kMobileMinHeight = 480;
  static double kMobileMinWidth = 320;
  static double kMobileMaxHeight = 896;
  static double kMobileMaxWidth = 410;

  static double kTabletMinHeight = 1024;
  static double kTabletMinWidth = 768;
  static double kTabletMaxHeight = 1366;
  static double kTabletMaxWidth = 1024;

  static double kDesktopMinHeight = 1024;
  static double kDesktopMinWidth = 1440;
  static double kDesktopMaxHeight = 1024;
  static double kDesktopMaxWidth = 1366;
}

enum MyDeviceType {
  mobilePortrait,
  mobileLandscape,
  tabletPortrait,
  tabletLandscape,
  desktopPortrait,
  desktopLandscape,
}
