import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUsecase extends BaseUsecase<User, SignUpUsecaseInputs> {
  final AuthRepository _authRepository;
  SignUpUsecase(this._authRepository);
  @override
  Future<Either<Failure, User>> call(SignUpUsecaseInputs parameters) async {
    return await _authRepository.signUp(
        parameters.username, parameters.email, parameters.password);
  }
}

class SignUpUsecaseInputs {
  final String username;
  final String email;
  final String password;

  SignUpUsecaseInputs(this.username, this.email, this.password);
}
