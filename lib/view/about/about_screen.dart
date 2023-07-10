import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/settings/widgets/custom_list_tile.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';

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
              icon: AssetsIconPath.lock,
              title: AppStrings.privacyStetesment,
              onTap: () {},
            ),
            inkwellListTile(
              icon: AssetsIconPath.info,
              title: AppStrings.faq,
              onTap: () {},
            ),
            inkwellListTile(
              icon: AssetsIconPath.infoSquare,
              title: AppStrings.appFeedback,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
