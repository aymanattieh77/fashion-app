import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/view/cart/widgets/count_widget.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({
    super.key,
    required this.entity,
  });

  final ProductDetailEntity entity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: AppColor.white2,
              borderRadius: BorderRadius.circular(15),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 3,
              child: Image.network(
                entity.images[0],
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextUtils(
                  text: entity.name,
                  fontSize: 14,
                  maxlines: 2,
                  color: Theme.of(context).primaryColorLight,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextUtils(
                      text: 'Color : ',
                      fontSize: 14,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                          color: AppColor.yallowLight, shape: BoxShape.circle),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextUtils(
                      text: '\$${entity.currentPrice}',
                      fontSize: 16,
                      fontWe: FontWe.medium,
                    ),
                    const Spacer(),
                    CountWidget(entity: entity)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
