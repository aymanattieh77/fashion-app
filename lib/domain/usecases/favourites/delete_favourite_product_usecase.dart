import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class DeleteFavouriteProductUsecase
    extends BaseUsecase<void, DeleteFavouriteInputs> {
  final FirebaseFavouriteRepository _repository;
  DeleteFavouriteProductUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(DeleteFavouriteInputs parameters) async {
    return await _repository.deleteFavouriteProduct(
        parameters.productId, parameters.userUid);
  }
}

class DeleteFavouriteInputs {
  int productId;
  String userUid;
  DeleteFavouriteInputs(this.productId, this.userUid);
}
