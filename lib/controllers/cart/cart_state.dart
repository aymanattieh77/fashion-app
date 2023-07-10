part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class AddToCart extends CartState {}

class RemoveFromCart extends CartState {}

class IncreaseCount extends CartState {}

class DecreaseCount extends CartState {}
