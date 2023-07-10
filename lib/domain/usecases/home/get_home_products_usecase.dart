import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';

import '../../entities/product/product_entity.dart';
import '../base_usecase.dart';

class GetHomeProductsUsecase
    implements BaseUsecase<List<ProductEntity>, HomeProductsInputs> {
  final HomeRepository _repository;
  GetHomeProductsUsecase(this._repository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      HomeProductsInputs parameters) async {
    return await _repository.getHomeProducts(
        categoryId: parameters.categoryId, offset: parameters.offset);
  }
}

class HomeProductsInputs {
  final int categoryId;
  final int offset;
  HomeProductsInputs(this.categoryId, this.offset);
}
