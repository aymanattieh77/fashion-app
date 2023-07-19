import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/strings.dart';

class CustomAddressTextField extends StatelessWidget {
  const CustomAddressTextField({
    super.key,
    required this.hint,
    this.controller,
    this.optional = false,
    required this.textInputType,
  });
  final String hint;
  final bool optional;
  final TextEditingController? controller;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: (value) {
        if (optional) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return AppStrings.pleaseFillTheField.tr();
        }
        return null;
      },
      style: TextStyle(color: context.primaryColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.primaryColor,
          ),
        ),
        hintText: hint.tr(),
        hintStyle: TextStyle(color: context.primaryColorLight),
      ),
    );
  }
}
