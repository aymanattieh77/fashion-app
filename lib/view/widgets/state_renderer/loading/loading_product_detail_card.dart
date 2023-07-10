import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/product_details/widgets/custom_color_picker.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/shimmer_effect.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class LoadingProductDetailCard extends StatelessWidget {
  const LoadingProductDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        ShimmerEffect(
          enabled: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            child: const AspectRatio(
                aspectRatio: 0.3,
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20 - 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p5),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AssetsIconPath.heart),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: context.fullWidth(),
            height: context.setHeight(0.55),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20, vertical: AppPadding.p20 + 10),
              child: ShimmerEffect(
                enabled: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 2,
                            lineStyle: SkeletonLineStyle(
                                width: 100,
                                height: 10,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 50,
                                  height: 15,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 50,
                                  height: 15,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.s10),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                        lines: 3,
                        lineStyle: SkeletonLineStyle(
                            width: double.infinity,
                            height: 10,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    TextUtils(
                        text: '${AppStrings.color.tr()} :',
                        fontSize: 14,
                        tr: false,
                        color: Theme.of(context).primaryColorLight),
                    const SizedBox(height: AppSizes.s10),
                    const CustomColorPicker(),
                    const SizedBox(height: AppSizes.s24),
                    Center(
                      child: CustomElevatedButton(
                        label: AppStrings.addToCart,
                        press: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
