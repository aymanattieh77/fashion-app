import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/widgets/common/custom_buttons.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.message,
      this.cancelText = 'Cancel',
      this.confirmText = 'Confirm',
      required this.onCancel,
      required this.onConfirm});

  final String message;
  final String cancelText;
  final String confirmText;
  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p20,
      ),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppSizes.s50,
            height: AppSizes.s50,
            child: SvgPicture.asset(AssetsIconPath.appIcon),
          ),
          const SizedBox(height: AppSizes.s20),
          TextUtils(
            text: message,
            fontSize: 16,
            fontWe: FontWe.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.s20),
          Row(
            children: [
              Expanded(
                child: customButton(label: cancelText, press: onCancel),
              ),
              const SizedBox(width: AppSizes.s10),
              Expanded(
                child: customButton(label: confirmText, press: onConfirm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
