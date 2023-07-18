import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetFavouritesProductsUsecase
    extends BaseUsecase<List<ProductsFavourite>, String> {
  final FirebaseFavouriteRepository _repository;
  GetFavouritesProductsUsecase(this._repository);
  @override
  Future<Either<Failure, List<ProductsFavourite>>> call(
      String parameters) async {
    return await _repository.getFavourtiesProducts(parameters);
  }
}
