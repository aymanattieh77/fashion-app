import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/view/categories/widgets/categories_product_gridview.dart';

import '../../../core/functions/state_renderer.dart';

class CategoryBodySection extends StatelessWidget {
  const CategoryBodySection({
    super.key,
    required this.categoryId,
  });
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller:
          BlocProvider.of<CategoryProductCubit>(context).scrollController,
      slivers: [
        const SliverToBoxAdapter(child: CategoriesProductGirdview()),
        SliverToBoxAdapter(child: _loadingMoreProducts())
      ],
    );
  }
}

_loadingMoreProducts() {
  return BlocBuilder<CategoryProductCubit, CategoryProductState>(
    builder: (context, state) {
      if (BlocProvider.of<CategoryProductCubit>(context).isLoadMore) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: loadingCircularWidget(),
        );
      }
      return Container();
    },
  );
}
