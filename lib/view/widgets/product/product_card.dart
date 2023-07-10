import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/service_locator.dart';

import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/product_details/product_details_screen.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/product_detail/product_detail_cubit.dart';
import '../../../core/utils/utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.label,
      required this.image,
      required this.price,
      required this.id});
  final String label;
  final String image;
  final String price;
  final int id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setupProductDetail();
        context.goTo(
          BlocProvider(
            create: (context) =>
                getIt<ProductDetailCubit>()..getProdcutDetailById(id),
            child: ProductDetailsScreen(productId: id),
          ),
        );
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
                  text: price,
                  fontSize: 14,
                  tr: false,
                  fontWe: FontWe.medium,
                ),
                const Spacer(),
                BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    bool isFav = BlocProvider.of<FavouriteCubit>(context)
                        .isFavourite(id);
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<FavouriteCubit>(context).favBtn(id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p5),
                        decoration: const BoxDecoration(
                            color: AppColor.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          isFav
                              ? AssetsIconPath.heart
                              : AssetsIconPath.heartBorder,
                          colorFilter: isFav
                              ? null
                              : const ColorFilter.mode(
                                  AppColor.black, BlendMode.srcIn),
                        ),
                      ),
                    );
                  },
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
