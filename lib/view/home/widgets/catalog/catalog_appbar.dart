import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/home/widgets/main/menu_widget.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CatalogAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TextUtils(text: AppStrings.catalog),
      centerTitle: true,
      leading: const MenuIconWidget(),
      bottom: TabBar(
        dividerColor: AppColor.orange,
        indicatorColor: AppColor.orange,
        labelColor: AppColor.orange,
        unselectedLabelColor: AppColor.gray,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        indicatorWeight: 4.0,
        tabs: [
          Tab(
            text: AppStrings.mens.tr(),
          ),
          Tab(
            text: AppStrings.womens.tr(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s100);
}
