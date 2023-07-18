import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/view/widgets/product/product_card.dart';

class FavouritesProductsGridview extends StatelessWidget {
  const FavouritesProductsGridview(
      {super.key, required this.favouriteProducts});
  final List<ProductsFavourite> favouriteProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.60,
      ),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: AppPadding.p20,
        right: AppPadding.p20,
        top: AppPadding.p20 - 10,
      ),
      scrollDirection: Axis.vertical,
      itemCount: favouriteProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(
          id: favouriteProducts[index].productId,
          image: favouriteProducts[index].imageUrl,
          label: favouriteProducts[index].name,
          price: favouriteProducts[index].price,
        );
      },
    );
  }
}
