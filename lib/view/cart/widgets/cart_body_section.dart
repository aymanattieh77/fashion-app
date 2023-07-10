import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/cart/widgets/cart_listview.dart';
import 'package:fashion_app/view/widgets/state_renderer/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBodySection extends StatelessWidget {
  const CartBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (BlocProvider.of<CartCubit>(context).carts.isEmpty) {
          return const EmptyState(
              icon: Icons.shopping_basket, message: AppStrings.cartIsEmpty);
        }
        return const CartListView();
      },
    );
  }
}
