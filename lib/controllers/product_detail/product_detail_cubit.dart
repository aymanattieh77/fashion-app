import 'package:equatable/equatable.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/usecases/detail/get_product_detail_by_id.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._usecase) : super(ProductDetailInitial());
  final GetProdcutDetailById _usecase;

  ProductDetailEntity? productDetailEntity;

  getProdcutDetailById(int productId) async {
    emit(ProductDetailLoading());
    (await _usecase.call(productId)).fold(
      (failure) {
        emit(ProductDetailFailure(failure.message));
      },
      (productDetail) {
        productDetailEntity = productDetail;
        emit(ProductDetailLoaded());
      },
    );
  }
}
