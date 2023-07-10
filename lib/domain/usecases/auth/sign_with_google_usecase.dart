import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignINWithGoogleUsecase extends BaseUsecase<User, NoParameters> {
  final AuthRepository _authRepository;
  SignINWithGoogleUsecase(this._authRepository);
  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await _authRepository.signInWithGoogle();
  }
}
