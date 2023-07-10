import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetFavouritesProductsUsecase
    extends BaseUsecase<List<ProductDetailEntity>, NoParameters> {
  final FirebaseFavouriteRepository _repository;
  GetFavouritesProductsUsecase(this._repository);
  @override
  Future<Either<Failure, List<ProductDetailEntity>>> call(
      NoParameters parameters) async {
    return await _repository.getFavourtiesProducts();
  }
}
