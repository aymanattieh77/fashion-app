import 'package:flutter/material.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class FullScreenFailureState extends StatelessWidget {
  const FullScreenFailureState(
      {super.key, required this.message, required this.press});

  final String message;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.scaffoldBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: context.primaryColor, size: 100),
              const TextUtils(
                text: AppStrings.somthingWentWrong,
                fontSize: 20,
                fontWe: FontWe.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextUtils(text: message, fontSize: 15),
              const SizedBox(height: 20),
              CustomElevatedButton(label: AppStrings.tryAgain, press: press),
            ],
          ),
        ),
      ),
    );
  }
}
