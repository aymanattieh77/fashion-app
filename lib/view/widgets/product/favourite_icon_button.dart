import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';

class FavouriteIconButton extends StatelessWidget {
  const FavouriteIconButton(
      {super.key,
      required this.productId,
      required this.name,
      required this.image,
      required this.price});
  final int productId;
  final String name;
  final String image;
  final double price;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        bool isFav =
            BlocProvider.of<FavouriteCubit>(context).isFavourite(productId);
        return InkWell(
          onTap: () {
            final prodFav = ProductsFavourite(
              productId: productId,
              name: name,
              price: price,
              imageUrl: image,
            );
            BlocProvider.of<FavouriteCubit>(context).favBtn(prodFav, productId);
          },
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p5),
            decoration: const BoxDecoration(
                color: AppColor.white, shape: BoxShape.circle),
            child: SvgPicture.asset(
              isFav ? AssetsIconPath.heart : AssetsIconPath.heartBorder,
              colorFilter: isFav
                  ? null
                  : const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
            ),
          ),
        );
      },
    );
  }
}
