import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  double platformWidth = getPlatformWidth(screenWidth);

  double scaleFactor = screenWidth / platformWidth;
  double responsiveFontSize = scaleFactor * fontSize;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  double finalFontSize = responsiveFontSize.clamp(lowerLimit, upperLimit);

  // debugPrint('------------------------------');
  // debugPrint('📱 Screen width: $screenWidth');
  // debugPrint('📏 Platform width: $platformWidth');
  // debugPrint('🔹 Original font size: $fontSize');
  // debugPrint('🔸 Before clamp: ${responsiveFontSize.toStringAsFixed(2)}');
  // debugPrint('✅ Final (after clamp): ${finalFontSize.toStringAsFixed(2)}');
  // debugPrint('------------------------------');

  return finalFontSize;
}

double getPlatformWidth(double screenWidth) {
  if (screenWidth < SizeConfig.mobileBreakpoint) {
    return 400;
  } else if (screenWidth < SizeConfig.tabletBreakPoint) {
    return 850;
  } else {
    return 1200;
  }
}
