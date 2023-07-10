import 'package:fashion_app/controllers/home/home_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/domain/entities/product/product_category.dart';

import 'package:fashion_app/view/home/widgets/home/header_section.dart';
import 'package:fashion_app/view/home/widgets/home/products_categories_list_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBodySection extends StatelessWidget {
  const HomeBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeProductsFailure) {
          showFullScreenErrorState(context, state.message);
        }
      },
      child: RefreshIndicator(
        color: AppColor.orange,
        backgroundColor: context.scaffoldBackgroundColor,
        onRefresh: BlocProvider.of<HomeCubit>(context).onRefresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: HeaderSection()),
            ...(_getHomeProductsSections()), //contains all products categories widgtes
          ],
        ),
      ),
    );
  }

  List<SliverToBoxAdapter> _getHomeProductsSections() {
    return List.generate(
      AllProdcutCategories.categories.length,
      (index) {
        return SliverToBoxAdapter(
          child: ProductsCategoriesListSection(
            title: AllProdcutCategories.categories[index].categoryName,
            categoryId: AllProdcutCategories.categories[index].categoryId,
          ),
        );
      },
    ).toList();
  }
}
