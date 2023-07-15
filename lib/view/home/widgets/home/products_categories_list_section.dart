import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/home/home_cubit.dart';

import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/widgets/product/product_card_listview.dart';

import 'package:fashion_app/view/widgets/state_renderer/loading/loading_indicator_listview.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class ProductsCategoriesListSection extends StatelessWidget {
  const ProductsCategoriesListSection(
      {super.key, required this.title, required this.categoryId});
  final String title;
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: TextUtils(
                  text: title,
                  fontSize: 16,
                  fontWe: FontWe.medium,
                  maxlines: 1,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _seeAllTap(context);
                },
                child: TextUtils(
                  text: AppStrings.seeAll,
                  fontSize: 14,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeProductLoading) {
              return const LoadingIndicatorListview();
            } else if (state is HomeProductsFailure) {
              return Container();
            } else if (state is HomeProductLoaded) {
              return ProductCardListview(
                products: BlocProvider.of<HomeCubit>(context)
                    .prodcutsList(categoryId),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  _seeAllTap(BuildContext context) {
    BlocProvider.of<AppCubit>(context)
        .goToProductCategoriesPage(context, categoryId, title);
  }
}
