import 'package:fashion_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    appBarTheme: appbarThemeLight,
    sliderTheme: sliderTheme,
    scaffoldBackgroundColor: AppColor.white,
    primaryColor: AppColor.black,
    primaryColorLight: AppColor.black50,
    cardColor: AppColor.white,
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: AppColor.black),
    ),
  );
  static final darkTheme = ThemeData(
    appBarTheme: appbarThemeDark,
    sliderTheme: sliderTheme,
    scaffoldBackgroundColor: AppColor.blackBg,
    primaryColor: AppColor.white,
    cardColor: AppColor.blackBg,
    primaryColorLight: AppColor.white50,
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: AppColor.white),
    ),
  );

  static const appbarThemeLight = AppBarTheme(
    elevation: 0.0,
    backgroundColor: AppColor.white,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
  static const appbarThemeDark = AppBarTheme(
    elevation: 0.0,
    backgroundColor: AppColor.blackBg,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static const sliderTheme = SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    rangeValueIndicatorShape: RectangularRangeSliderValueIndicatorShape(),
    valueIndicatorColor: AppColor.white,
    valueIndicatorTextStyle: TextStyle(color: AppColor.black),
  );
}
