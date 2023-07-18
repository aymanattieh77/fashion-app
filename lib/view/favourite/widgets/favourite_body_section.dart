import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/product/product_card.dart';
import 'package:fashion_app/view/widgets/state_renderer/empty_state.dart';

class FavouriteBodySection extends StatelessWidget {
  const FavouriteBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (BlocProvider.of<FavouriteCubit>(context)
              .favouriteProducts
              .isEmpty) {
            return const EmptyState(
                icon: Icons.favorite, message: AppStrings.favorite);
          }
          if (state is FavouriteLoading) {
            return loadingCircularWidget();
          }
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
              itemCount: BlocProvider.of<FavouriteCubit>(context)
                  .favouriteProducts
                  .length,
              itemBuilder: (context, index) {
                return ProductCard(
                  id: BlocProvider.of<FavouriteCubit>(context)
                      .favouriteProducts[index]
                      .productId,
                  image: BlocProvider.of<FavouriteCubit>(context)
                      .favouriteProducts[index]
                      .imageUrl,
                  label: BlocProvider.of<FavouriteCubit>(context)
                      .favouriteProducts[index]
                      .name,
                  price: BlocProvider.of<FavouriteCubit>(context)
                      .favouriteProducts[index]
                      .price,
                );
              });
        },
      ),
    );
  }
}
