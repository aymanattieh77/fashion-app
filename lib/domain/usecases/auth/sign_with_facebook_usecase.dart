import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithFacebook extends BaseUsecase<User, NoParameters> {
  final AuthRepository _authRepository;
  SignInWithFacebook(this._authRepository);

  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await _authRepository.signInWithFacebook();
  }
}
