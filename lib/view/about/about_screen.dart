import 'package:flutter/material.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/settings/widgets/custom_list_tile.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.about),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.s20),
            inkwellListTile(
              icon: AssetsIconPath.info,
              title: AppStrings.faq,
              onTap: () {
                context.goToNamed(route: Routes.faq);
              },
            ),
            inkwellListTile(
              icon: AssetsIconPath.infoSquare,
              title: AppStrings.rateOurApp,
              onTap: () {
                context.goToNamed(route: Routes.rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
