import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
              color: AppColor.gray,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextUtils(text: AppStrings.or, fontSize: 12),
          ),
          Expanded(
              child: Divider(
            thickness: 2,
            color: AppColor.gray,
          )),
        ],
      ),
    );
  }
}
