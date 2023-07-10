import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class ClearFavouritesProductsUsecase extends BaseUsecase<void, NoParameters> {
  final FirebaseFavouriteRepository _repository;
  ClearFavouritesProductsUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(NoParameters parameters) async {
    return await _repository.clearFavouritesProducts();
  }
}
