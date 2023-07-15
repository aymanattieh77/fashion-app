import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/domain/entities/product/product_category.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CatalogBodySection extends StatelessWidget {
  const CatalogBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        MenWomenCatalogGirdview(categories: MenCategory.categories),
        MenWomenCatalogGirdview(categories: WomenCategory.categories),
      ],
    );
  }
}

class MenWomenCatalogGirdview extends StatelessWidget {
  const MenWomenCatalogGirdview({super.key, required this.categories});
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 4 / 6,
      ),
      itemBuilder: (context, index) {
        return ProductCategoryCard(
          categoryName: categories[index].categoryName,
          categoryId: categories[index].categoryId,
          image: categories[index].image ?? "",
        );
      },
    );
  }
}

class ProductCategoryCard extends StatelessWidget {
  const ProductCategoryCard({
    super.key,
    required this.image,
    required this.categoryId,
    required this.categoryName,
  });
  final String image;
  final int categoryId;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppCubit>(context)
            .goToProductCategoriesPage(context, categoryId, categoryName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: TextUtils(
              text: categoryName,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
