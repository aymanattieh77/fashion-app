import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';

class CustomAdvancedDrawer extends StatelessWidget {
  const CustomAdvancedDrawer(
      {super.key,
      required this.controller,
      required this.child,
      required this.drawer});
  final AdvancedDrawerController controller;
  final Widget child;
  final Widget drawer;
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: context.isRTL,
      disabledGestures: false, // disable swipe
      openScale: 0.8,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: context.isDark
              ? AppColor.blackBg.withOpacity(0.9)
              : AppColor.white2,
        ),
      ),
      childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      drawer: drawer,
      child: child,
    );
  }
}
