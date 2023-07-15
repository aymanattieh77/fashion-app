import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/view/categories/widgets/custom_category_appbar.dart';
import 'package:fashion_app/view/widgets/common/back_to_top_button.dart';

import 'widgets/category_body_section.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key, required this.categoryId, required this.categoryName});
  final int categoryId;
  final String categoryName;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final CategoryProductCubit cubit;
  @override
  void initState() {
    super.initState();

    cubit = BlocProvider.of<CategoryProductCubit>(context)
      ..start(context, widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppbar(
        title: widget.categoryName,
        categoryId: widget.categoryId,
      ),
      body: CategoryBodySection(categoryId: widget.categoryId),
      floatingActionButton:
          BackToTopButton(scrollController: cubit.scrollController),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
