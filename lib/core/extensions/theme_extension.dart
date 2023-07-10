import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/config/language/language_manager.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  Color get primaryColor {
    return Theme.of(this).primaryColor;
  }

  Color get primaryColorLight {
    return Theme.of(this).primaryColorLight;
  }

  Color get scaffoldBackgroundColor {
    return Theme.of(this).scaffoldBackgroundColor;
  }

  bool get isDark {
    return Theme.of(this).scaffoldBackgroundColor == AppColor.blackBg;
  }

  bool get isRTL {
    return locale == arabicLocale;
  }
}
