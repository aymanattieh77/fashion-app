import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/shimmer_effect.dart';
import 'package:fashion_app/view/widgets/state_renderer/skeleton_widgets.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorListview extends StatelessWidget {
  const LoadingIndicatorListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      enabled: true,
      child: SizedBox(
        height: context.setHeight(0.40),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: AppPadding.p20),
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const CustomSkeletonWidget();
          },
          separatorBuilder: (context, index) =>
              const SizedBox(width: AppSizes.s10),
        ),
      ),
    );
  }
}
