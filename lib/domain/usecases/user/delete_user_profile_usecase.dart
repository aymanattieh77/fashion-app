import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class DeleteUserProfileUsecase extends BaseUsecase<void, String> {
  final FirebaseUserRepository _repository;
  DeleteUserProfileUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(String parameters) async {
    return await _repository.deleteUserProfile(parameters);
  }
}
