import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/home/widgets/main/menu_widget.dart';
import 'package:fashion_app/view/home/widgets/profile/custom_drop_menu.dart';

import 'package:flutter/material.dart';

class CustomProfileAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const MenuIconWidget(),
      actions: const [CustomDropMenu()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s55);
}
