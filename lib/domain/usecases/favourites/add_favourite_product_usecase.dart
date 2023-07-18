import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class AddFavouriteProductUsecase extends BaseUsecase<void, AddFavouriteInputs> {
  final FirebaseFavouriteRepository _repository;
  AddFavouriteProductUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(AddFavouriteInputs parameters) async {
    return await _repository.addFavouriteProduct(
        parameters.favouriteProduct, parameters.userUid);
  }
}

class AddFavouriteInputs {
  ProductsFavourite favouriteProduct;
  String userUid;
  AddFavouriteInputs(this.favouriteProduct, this.userUid);
}
