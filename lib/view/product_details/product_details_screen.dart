import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';

import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/controllers/product_detail/product_detail_cubit.dart';

import 'package:fashion_app/core/functions/state_renderer.dart';

import 'package:fashion_app/core/utils/utils.dart';

import 'package:fashion_app/view/widgets/product/product_detail_card.dart';

import 'package:fashion_app/view/widgets/state_renderer/loading/loading_product_detail_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColor.white2,
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoading) {
                return const LoadingProductDetailCard();
              } else if (state is ProductDetailFailure) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showFullScreenErrorState(context, state.message);
                });
                return Container();
              } else if (state is ProductDetailLoaded) {
                final entity = BlocProvider.of<ProductDetailCubit>(context)
                    .productDetailEntity!;
                return ProductDetailCard(
                  controller: pageController,
                  entity: entity,
                  addToCart: () {
                    BlocProvider.of<CartCubit>(context).addToCart(entity);
                    context.goToNamed(route: Routes.cart, replacement: true);
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
