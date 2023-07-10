import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/cart/widgets/cart_body_section.dart';
import 'package:fashion_app/view/cart/widgets/checkout_and_subtotal.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.myCart),
      body: CartBodySection(),
      floatingActionButton: CheckoutAndSubtotal(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
