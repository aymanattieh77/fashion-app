import 'package:fashion_app/view/favourite/widgets/favourites_products_girdview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/strings.dart';
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
          return FavouritesProductsGridview(
            favouriteProducts:
                BlocProvider.of<FavouriteCubit>(context).favouriteProducts,
          );
        },
      ),
    );
  }
}
