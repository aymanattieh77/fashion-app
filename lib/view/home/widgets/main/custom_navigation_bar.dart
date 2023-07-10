import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/core/utils/utils.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      selectedItemColor: AppColor.orange,
      unselectedItemColor: Theme.of(context).primaryColorLight,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppStrings.home.tr(),
          activeIcon: SvgPicture.asset(AssetsIconPath.homeFill),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: AppStrings.catalog.tr(),
          activeIcon: const Icon(
            Icons.menu,
            color: AppColor.orange,
          ),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          activeIcon: SvgPicture.asset(AssetsIconPath.profile),
          label: AppStrings.profile.tr(),
        ),
      ],
    );
  }
}
