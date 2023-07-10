import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

import '../../widgets/product/product_cart.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final carts = BlocProvider.of<CartCubit>(context).carts;
    return SizedBox(
      height: context.setHeight(0.72),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: carts.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: AppColor.red,
              alignment: Alignment.center,
              child: const TextUtils(
                text: 'Delete',
                fontSize: 22,
                color: AppColor.white,
              ),
            ),
            onDismissed: (direction) {
              BlocProvider.of<CartCubit>(context)
                  .removeFromCart(carts.keys.toList()[index].id);
            },
            child: ProductCart(
              entity: carts.keys.toList()[index],
            ),
          );
        },
      ),
    );
  }
}
