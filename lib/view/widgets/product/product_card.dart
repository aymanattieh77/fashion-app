import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:fashion_app/view/widgets/product/favourite_icon_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.label,
      required this.image,
      required this.price,
      required this.id});
  final String label;
  final String image;
  final double price;
  final int id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppCubit>(context).goToProductDetailScreen(context, id);
      },
      child: SizedBox(
        width: context.setWidth(0.42),
        height: context.setHeight(0.42),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 0.95,
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.s5),
            Row(
              children: [
                TextUtils(
                  text: '\$${price}0',
                  fontSize: 14,
                  tr: false,
                  fontWe: FontWe.medium,
                ),
                const Spacer(),
                FavouriteIconButton(
                  productId: id,
                  name: label,
                  image: image,
                  price: price,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.s5),
            TextUtils(
              text: label,
              tr: false,
              fontSize: 14,
              maxlines: 2,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
