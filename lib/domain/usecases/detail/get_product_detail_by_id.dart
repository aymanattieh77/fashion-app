import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetProdcutDetailById implements BaseUsecase<ProductDetailEntity, int> {
  final ProductDetailRepository _repository;
  GetProdcutDetailById(this._repository);
  @override
  Future<Either<Failure, ProductDetailEntity>> call(int parameters) async {
    return await _repository.getProdcutDetail(productId: parameters);
  }
}
