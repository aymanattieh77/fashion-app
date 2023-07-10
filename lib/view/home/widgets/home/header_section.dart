import 'package:flutter/material.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/search/widgets/custom_search_field.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextUtils(
                  text: AppStrings.explore, fontSize: 25, fontWe: FontWe.bold),
              const SizedBox(height: AppSizes.s10),
              TextUtils(
                text: AppStrings.bestOutfitsForYou,
                fontSize: 25,
                fontWe: FontWe.regular,
                color: Theme.of(context).primaryColorLight,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.s20),
        InkWell(
          onTap: () {
            context.goToNamed(route: Routes.search);
          },
          child: const CustomSearchField(
            enabled: false,
          ),
        ),
        const SizedBox(height: AppSizes.s20),
      ],
    );
  }
}
