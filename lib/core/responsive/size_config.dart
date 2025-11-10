import 'package:flutter/material.dart';

abstract class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late double textSize;
  static double mobileBreakpoint = 600.0;
  static double tabletBreakPoint = 1200.0;

  static void init(BuildContext context) {
    screenWidth = isLandScape(context)
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    screenHeight = isLandScape(context)
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    blockHeight = screenHeight / 100;
    blockWidth = screenWidth / 100;
    textSize = blockHeight;
  }

  static bool isLandScape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool get isMobile => screenWidth <= 600.0;
  static bool get isTablet => screenWidth > 600.0 && screenWidth <= 1200;
  static bool get isDesktop => screenWidth > 1200.0;
}
