import 'package:equatable/equatable.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Map<ProductDetailEntity, int> carts = {};

  String get productsInCart {
    if (carts.isEmpty) {
      return '0';
    } else {
      return carts.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toString();
    }
  }

  addToCart(ProductDetailEntity entity) {
    if (carts.containsKey(entity)) {
      carts[entity] = carts[entity]! + 1;
    } else {
      carts[entity] = 1;
    }
    emit(AddToCart());
  }

  removeOneProductFromCart(ProductDetailEntity entity) {
    if (carts.containsKey(entity) && carts[entity] == 1) {
      removeFromCart(entity.id);
    } else {
      carts[entity] = carts[entity]! - 1;
    }
    emit(RemoveFromCart());
  }

  removeFromCart(int id) {
    carts.removeWhere((entity, count) => entity.id == id);
    emit(RemoveFromCart());
  }

  int getProductCount(ProductDetailEntity entity) {
    int count = 1;
    if (carts.containsKey(entity)) {
      count = carts[entity]!;
      emit(IncreaseCount());
    }

    return count;
  }

  clearAllProductsInCart() {
    carts.clear();
    emit(RemoveFromCart());
  }

  double subTotal() {
    final sTotal = carts.entries
        .map((e) => e.key.currentPrice * e.value)
        .reduce((value, element) => value + element);

    return sTotal;
  }
}
