import 'package:flutter/material.dart';

const String arabic = 'ar';
const String english = 'en';
const String assetsPathLocalization = 'assets/translations';

const Locale arabicLocale = Locale('ar', 'SA');
const Locale englishLocale = Locale('en', 'US');

enum LanguageType { english, arabic }

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}
