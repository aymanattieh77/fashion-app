import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    this.suffix,
    required this.title,
    this.switchTap = false,
  });

  final String icon;
  final Widget? suffix;
  final String title;
  final bool switchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20 - 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.s24,
                height: AppSizes.s24,
                decoration: BoxDecoration(
                    color: AppColor.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
              const SizedBox(width: AppSizes.s15),
              TextUtils(text: title, fontSize: 14),
            ],
          ),
          if (switchTap) suffix ?? Container(),
          if (!switchTap)
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColor.gray,
            ),
        ],
      ),
    );
  }
}

Widget inkwellListTile(
    {required String title, required String icon, required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: CustomListTile(
      icon: icon,
      title: title,
    ),
  );
}

Widget swaithListTile({
  required String title,
  required String icon,
  required bool value,
  required void Function(bool)? onChanged,
}) {
  return CustomListTile(
    icon: icon,
    switchTap: true,
    suffix: Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: AppColor.white,
      activeTrackColor: AppColor.orange,
      inactiveThumbColor: AppColor.white,
      inactiveTrackColor: AppColor.orange,
    ),
    title: title,
  );
}
