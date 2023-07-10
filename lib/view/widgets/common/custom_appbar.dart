import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.back();
        },
        icon: Icon(Icons.arrow_back_ios, color: context.primaryColor),
      ),
      centerTitle: true,
      title: TextUtils(
        text: title,
        fontSize: 20,
        fontWe: FontWe.medium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s55);
}
