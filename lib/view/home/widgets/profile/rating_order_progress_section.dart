import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RatingOrderProgressSection extends StatelessWidget {
  const RatingOrderProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.setHeight(0.22),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingOrderProgressCard(
            icon: AssetsIconPath.bag,
            label: AppStrings.progressOrder,
            value: '10+',
          ),
          RatingOrderProgressCard(
            icon: AssetsIconPath.ticket,
            label: AppStrings.promocodes,
            value: '5',
          ),
          RatingOrderProgressCard(
            icon: AssetsIconPath.star,
            label: AppStrings.reviewes,
            value: '4.5K',
          ),
        ],
      ),
    );
  }
}

class RatingOrderProgressCard extends StatelessWidget {
  const RatingOrderProgressCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                blurRadius: 0.50,
                offset: const Offset(2, 3),
              ),
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppPadding.p15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.orange.withOpacity(0.07),
              ),
              child: SvgPicture.asset(
                icon,
              ),
            ),
            const SizedBox(height: 7),
            TextUtils(
              text: label,
              fontSize: 10,
              fontWe: FontWe.medium,
              textAlign: TextAlign.center,
              color: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(height: 7),
            TextUtils(
              text: value,
              fontSize: 14,
              tr: false,
              fontWe: FontWe.medium,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
