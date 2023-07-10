import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/view/widgets/product/product_card.dart';

class ProductCardGirdview extends StatelessWidget {
  const ProductCardGirdview({
    Key? key,
    required this.products,
    this.physics,
    this.shrinkWrap,
    this.controller,
  }) : super(key: key);
  final List<ProductEntity> products;
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: controller,
        shrinkWrap: shrinkWrap ?? false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.60,
        ),
        physics: physics ?? const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: AppPadding.p20,
          right: AppPadding.p20,
          top: AppPadding.p20 - 10,
        ),
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            id: products[index].id,
            image: products[index].imageUrl,
            label: products[index].name,
            price: '\$${products[index].price}0',
          );
        });
  }
}
