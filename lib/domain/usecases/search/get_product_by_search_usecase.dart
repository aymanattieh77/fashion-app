import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetProductsBySearchUsecase
    implements BaseUsecase<List<ProductEntity>, ProductsSearchInputs> {
  final SearchProductRepository _repository;
  GetProductsBySearchUsecase(this._repository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      ProductsSearchInputs parameters) async {
    return _repository.getProdcutsBySearch(
      q: parameters.q,
      offset: parameters.offet,
      priceMax: parameters.priceMax,
      priceMin: parameters.priceMin,
      sort: parameters.sort,
    );
  }
}

class ProductsSearchInputs {
  final String q;
  final int? offet;
  final String? sort;
  final int? priceMax;
  final int? priceMin;
  ProductsSearchInputs({
    required this.q,
    this.offet,
    this.sort,
    this.priceMax,
    this.priceMin,
  });
}
