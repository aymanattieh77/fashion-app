import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show AuthRepository;
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecase extends BaseUsecase<User, LoginUsecaseInputs> {
  final AuthRepository _authRepository;
  LoginUsecase(this._authRepository);
  @override
  Future<Either<Failure, User>> call(LoginUsecaseInputs parameters) async {
    return await _authRepository.login(parameters.email, parameters.password);
  }
}

class LoginUsecaseInputs {
  final String email;
  final String password;
  LoginUsecaseInputs(this.email, this.password);
}
