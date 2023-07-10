import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  int currnetPaymentTap = 0;
  bool addressCheck = false;

  onChangePaymentMethod(int index) {
    currnetPaymentTap = index;
    emit(ChangePaymentMethod());
  }

  setAddress(bool? val) {
    addressCheck = val!;
    emit(CheckoutInitial());
  }

  double getPriceSubTotal(BuildContext context) {
    return BlocProvider.of<CartCubit>(context).subTotal();
  }

  List<ProductsInformations> getProductsInformations(BuildContext context) {
    final carts = BlocProvider.of<CartCubit>(context).carts;
    List<ProductsInformations> products = [];
    for (var item in carts.entries) {
      products.add(
        ProductsInformations(
          name: item.key.name,
          count: item.value,
          price: item.key.currentPrice,
        ),
      );
    }

    return products;
  }

  double getDeliveryFee() {
    return 3.00;
    //todo
  }

  double getFax() {
    return 2.125;
    //TODO
  }

  double getPriceTotal(BuildContext context) {
    return getDeliveryFee() + getPriceSubTotal(context) + getFax();
  }
}

class ProductsInformations {
  final String name;
  final int count;
  final double price;
  ProductsInformations(
      {required this.name, required this.count, required this.price});
}
