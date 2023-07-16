import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show AuthRepository;
import 'package:fashion_app/domain/usecases/auth/login_usecase.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class ReAuthenticatesUserUsecase extends BaseUsecase<void, LoginUsecaseInputs> {
  final AuthRepository _authRepository;
  ReAuthenticatesUserUsecase(this._authRepository);
  @override
  Future<Either<Failure, void>> call(LoginUsecaseInputs parameters) async {
    return await _authRepository.reAuthenticatesUser(
        parameters.email, parameters.password);
  }
}
