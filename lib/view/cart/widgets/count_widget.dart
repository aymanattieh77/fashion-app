import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/common/text_utils.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.entity,
  });

  final ProductDetailEntity entity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                _remove(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.remove,
                  size: 18,
                  color: context.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 17),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return _productCountText(context);
              },
            ),
            const SizedBox(width: 17),
            InkWell(
              onTap: () {
                _add(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: context.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _productCountText(BuildContext context) {
    return TextUtils(
      text: '${BlocProvider.of<CartCubit>(context).getProductCount(entity)}',
      fontSize: 16,
    );
  }

  _add(BuildContext context) {
    BlocProvider.of<CartCubit>(context).addToCart(entity);
  }

  _remove(BuildContext context) {
    BlocProvider.of<CartCubit>(context).removeOneProductFromCart(entity);
  }
}
