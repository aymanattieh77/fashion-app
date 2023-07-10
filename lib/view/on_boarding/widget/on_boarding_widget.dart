import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';

import 'package:fashion_app/core/utils/colors.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 4 / 2,
          child: SizedBox(
            height: context.setHeight(0.3),
            child: SvgPicture.asset(image),
          ),
        ),
        const SizedBox(height: 30),
        TextUtils(
          text: title,
          fontSize: 22,
          fontWe: FontWe.medium,
          color: AppColor.black,
        ),
        const SizedBox(height: 16),
        TextUtils(
          text: description,
          fontSize: 14,
          color: AppColor.black50,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
