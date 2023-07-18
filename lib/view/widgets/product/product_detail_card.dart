import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/view/product_details/widgets/custom_color_picker.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:fashion_app/view/widgets/product/favourite_icon_button.dart';

class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({
    super.key,
    required this.entity,
    required this.addToCart,
    required this.controller,
  });
  final ProductDetailEntity entity;
  final Function() addToCart;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SizedBox(
          height: context.setHeight(0.5),
          width: context.fullWidth(),
          child: PageView.builder(
            itemCount: entity.images.length,
            controller: controller,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 0.3,
                child: Image.network(
                  entity.images[index],
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20 - 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Spacer(),
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     padding: const EdgeInsets.all(AppPadding.p5),
              //     decoration: const BoxDecoration(
              //       color: AppColor.white,
              //       shape: BoxShape.circle,
              //     ),
              //     child: SvgPicture.asset(AssetsIconPath.heart),
              //   ),
              // ),
              FavouriteIconButton(
                productId: entity.id,
                name: entity.name,
                image: entity.images[0],
                price: entity.currentPrice,
              ),
            ],
          ),
        ),
        Positioned(
          top: context.setHeight(0.35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: entity.images.length,
                effect: const WormEffect(
                    activeDotColor: AppColor.orange,
                    radius: 12,
                    dotHeight: 12,
                    dotWidth: 12),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: TextUtils(
                          //Gender //categoryName // Brand
                          text:
                              '${entity.gender}\n${entity.categoryName}\n${entity.brand}',
                          fontSize: 20,
                          fontWe: FontWe.medium,
                          tr: false,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          TextUtils(
                            text: '\$${entity.previousPrice}',
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            color: context.primaryColorLight,
                            tr: false,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextUtils(
                            text: '\$${entity.currentPrice}',
                            fontSize: 18,
                            fontWe: FontWe.medium,
                            tr: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s10),
                  TextUtils(
                    text: entity.name,
                    fontSize: 12,
                    tr: false,
                    color: Theme.of(context).primaryColorLight,
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
                      press: addToCart,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
