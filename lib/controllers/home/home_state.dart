part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryProductTapChange extends HomeState {}

class HomeProductLoading extends HomeState {}

class HomeProductsFailure extends HomeState {
  final String message;
  HomeProductsFailure(this.message);
}

class HomeProductLoaded extends HomeState {}
