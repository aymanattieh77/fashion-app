import 'package:flutter/material.dart';

abstract class AppColor {
  static const Color orange = Color(0xffF67952);
  static const Color red = Color(0xFFFF3535);
  static const Color orangeLight = Color(0xffFFE9E2);
  static const Color green = Color(0xff39CE8A);
  static const Color black = Color(0xff000000);
  static const Color blackBg = Color(0xff191919);
  static const Color gray = Color(0xFF767680);
  static const Color white = Color(0xffFFFFFF);
  static const Color white2 = Color(0xffE5E5E5);
  static const Color white3 = Color(0xffFBFBFD);
  static const Color black50 = Color(0x80000000);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color borwan = Color(0xff230A06);
  static const Color borwan50 = Color(0x80230A06);
  static const Color lightgreen = Color(0xFFBEE8EA);
  static const Color darkBlue = Color(0xFF141B4A);
  static const Color lightBlue = Color(0xFFCEE3F5);

  static const Color yallowLight = Color(0xFFF4E5C3);
  static const Color productBackground = Color(0x0F333547);

  static final Color g = HexColor('#F4E5C3');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
