import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.label,
      required this.press,
      this.backgroundColor = AppColor.orange,
      this.textColor = AppColor.white});

  final String label;
  final void Function() press;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          minimumSize: const Size(double.infinity, AppSizes.s55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: press,
      child: TextUtils(text: label, color: textColor),
    );
  }
}
