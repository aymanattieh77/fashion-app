import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';

import 'package:fashion_app/config/language/language_manager.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/constants.dart';

enum FontWe { bold, medium, regular, semiBold }

class TextUtils extends StatelessWidget {
  const TextUtils(
      {super.key,
      required this.text,
      this.fontSize = 16.0,
      this.color,
      this.fontWe = FontWe.regular,
      this.textAlign = TextAlign.start,
      this.maxlines,
      this.softWrap,
      this.decoration,
      this.tr = true});
  final String text;
  final double fontSize;
  final Color? color;
  final FontWe fontWe;
  final TextAlign textAlign;
  final int? maxlines;
  final bool? softWrap;
  final bool tr;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      tr ? text.tr() : text,
      textDirection: context.isRTL ? TextDirection.rtl : TextDirection.ltr,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? context.primaryColor,
        fontWeight: _fontWeight(),
        decoration: decoration,
        fontFamily: tr ? _getFontFamily(context) : AppConstants.fontFamilyEn,
      ),
      textAlign: textAlign,
      maxLines: maxlines ?? 3,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap ?? true,
    );
  }

  String _getFontFamily(BuildContext context) {
    return context.locale == arabicLocale
        ? AppConstants.fontFamilyAr
        : AppConstants.fontFamilyEn;
  }

  _fontWeight() {
    switch (fontWe) {
      case FontWe.bold:
        return FontWeight.w700;
      case FontWe.semiBold:
        return FontWeight.w400;
      case FontWe.medium:
        return FontWeight.w500;
      case FontWe.regular:
        return FontWeight.w400;
    }
  }
}
