import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';

import '../../widgets/common/text_utils.dart';

class OrderAppbar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            context.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: context.primaryColor)),
      title: const TextUtils(text: AppStrings.myOrders),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s55);
}
