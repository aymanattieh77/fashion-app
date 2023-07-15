import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/account/user.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class GetUserProfileByIdUseCase extends BaseUsecase<UserModel, String> {
  final FirebaseUserRepository _repository;
  GetUserProfileByIdUseCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> call(String parameters) async {
    return await _repository.getUserProfileById(parameters);
  }
}
