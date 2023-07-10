import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';

class WalletAppbar extends StatelessWidget implements PreferredSizeWidget {
  const WalletAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TextUtils(
          text: AppStrings.myWallets, fontSize: 20, fontWe: FontWe.medium),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: context.primaryColor,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: context.primaryColor))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s55);
}
