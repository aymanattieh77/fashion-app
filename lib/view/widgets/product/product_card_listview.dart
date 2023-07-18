import 'package:flutter/material.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';

import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/domain/entities/product/product_entity.dart';

import 'package:fashion_app/view/widgets/product/product_card.dart';

class ProductCardListview extends StatelessWidget {
  const ProductCardListview({
    super.key,
    required this.products,
  });
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHeight(0.40),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: AppPadding.p20),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(
            id: products[index].id,
            label: products[index].name,
            price: products[index].price,
            image: products[index].imageUrl,
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSizes.s10),
      ),
    );
  }
}
