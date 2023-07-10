// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_product_cubit.dart';

abstract class CategoryProductState {}

class CategoryProductInitial extends CategoryProductState {}

class CategoryProductLoading extends CategoryProductState {}

class CategoryProductLoaded extends CategoryProductState {}

class CategoryProductFailure extends CategoryProductState {
  final String message;
  CategoryProductFailure(this.message);
}
