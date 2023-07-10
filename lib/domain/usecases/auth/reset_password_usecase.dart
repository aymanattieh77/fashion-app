import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class ResetPasswordUsecase extends BaseUsecase<void, String> {
  final AuthRepository _authRepository;
  ResetPasswordUsecase(this._authRepository);
  @override
  Future<Either<Failure, void>> call(String parameters) async {
    return await _authRepository.resetPassword(parameters);
  }
}
