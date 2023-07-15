import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/account/user.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class UpdateUserProfileUsecase extends BaseUsecase<void, UpdateUserInputs> {
  final FirebaseUserRepository _repository;
  UpdateUserProfileUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(UpdateUserInputs parameters) async {
    return await _repository.updateUserProfile(
        parameters.userModel, parameters.userUid);
  }
}

class UpdateUserInputs {
  UserModel userModel;
  String userUid;
  UpdateUserInputs(this.userModel, this.userUid);
}
