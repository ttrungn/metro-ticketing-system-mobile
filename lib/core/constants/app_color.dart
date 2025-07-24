import 'dart:ui';

//TODO Constant Convention:
//TODO class => ConstantClassName, non-class variable => kPropertyName

class ConstantAppColor {
  static const Color primary = Color.fromRGBO(85, 173, 155, 1);
  static const Color primaryLight = Color.fromRGBO(241, 248, 232, 1);
  static const Color primaryDark = Color.fromRGBO(65, 150, 135, 1);
  static const Color secondary = Color.fromRGBO(255, 206, 84, 1);
  static const Color accent = Color.fromRGBO(72, 201, 176, 1);

  // Text colors
  static const Color textPrimary = Color.fromRGBO(51, 51, 51, 1);
  static const Color textSecondary = Color.fromRGBO(102, 102, 102, 1);
  static const Color textLight = Color.fromRGBO(153, 153, 153, 1);

  // Background colors
  static const Color backgroundLight = Color.fromRGBO(248, 249, 250, 1);
  static const Color cardBackground = Color.fromRGBO(255, 255, 255, 1);

  // Status colors
  static const Color success = Color.fromRGBO(76, 175, 80, 1);
  static const Color warning = Color.fromRGBO(255, 193, 7, 1);
  static const Color error = Color.fromRGBO(244, 67, 54, 1);
  static const Color info = Color.fromRGBO(33, 150, 243, 1);
}

const kGlobalHomePagePadding = 20.0;
