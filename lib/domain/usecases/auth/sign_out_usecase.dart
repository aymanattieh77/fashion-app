import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class SignoutUsecase extends BaseUsecase<void, NoParameters> {
  final AuthRepository _authRepository;
  SignoutUsecase(this._authRepository);
  @override
  Future<Either<Failure, void>> call(NoParameters parameters) async {
    return await _authRepository.signOutFirebase();
  }
}
