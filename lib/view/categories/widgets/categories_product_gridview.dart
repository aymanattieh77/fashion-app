import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/view/widgets/product/product_card_gridview.dart';
import 'package:fashion_app/view/widgets/state_renderer/loading/loading_product_category_girdview.dart';

import '../../../core/functions/state_renderer.dart';

class CategoriesProductGirdview extends StatelessWidget {
  const CategoriesProductGirdview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryProductCubit, CategoryProductState>(
      listener: (context, state) {
        if (state is CategoryProductFailure) {
          showFullScreenErrorState(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is CategoryProductLoading) {
          return const LoadingProductCategoryGirdview(shrinkWrap: true);
        } else if (state is CategoryProductLoaded) {
          return ProductCardGirdview(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            products:
                BlocProvider.of<CategoryProductCubit>(context).productsList,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
