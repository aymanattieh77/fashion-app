import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

Widget customButton({required String label, required Function() press}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    onPressed: press,
    child: TextUtils(text: label, color: AppColor.white),
  );
}
