import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetProductsByFilterUsecase
    implements BaseUsecase<List<ProductEntity>, ProductsFilter> {
  final CategoryProductRepository _repository;
  GetProductsByFilterUsecase(this._repository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      ProductsFilter parameters) async {
    return await _repository.getProdcutsByCategoryId(
      categoryId: parameters.categoryId,
      offset: parameters.offset,
      priceMax: parameters.priceMax,
      priceMin: parameters.priceMin,
      sort: parameters.sort,
    );
  }
}

class ProductsFilter {
  int categoryId;
  int? offset;
  String? sort;
  int? priceMin;
  int? priceMax;

  ProductsFilter({
    required this.categoryId,
    this.offset,
    this.sort,
    this.priceMin,
    this.priceMax,
  });
}
