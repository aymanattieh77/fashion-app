import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CustomSkeletonWidget extends StatelessWidget {
  const CustomSkeletonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.setWidth(0.40),
      height: context.setHeight(0.42),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: SizedBox(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.s5),
          Row(
            children: [
              const SkeletonLine(
                style: SkeletonLineStyle(width: 30, height: 10),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppPadding.p5),
                child: const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                  width: 18,
                  height: 18,
                  shape: BoxShape.circle,
                )),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.s5),
          const SkeletonLine(
            style: SkeletonLineStyle(width: 200, height: 10),
          ),
        ],
      ),
    );
  }
}
