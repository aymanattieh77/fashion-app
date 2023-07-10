// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/data/remote/auth/auth_service.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show AuthRepository;
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await _authService.loginFirebase(email, password);
      if (user != null) {
        return Right(user);
      }
      return const Left(FirebaseFailure("Auth Failure"));
    } on AuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return const Right(Void);
    } on AuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
      String username, String email, String password) async {
    try {
      final user = await _authService.singUpFirebase(username, email, password);
      if (user != null) {
        return Right(user);
      }
      return const Left(FirebaseFailure("Auth Failure"));
    } on AuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithFacebook() async {
    try {
      final user = await _authService.signInWithFacebook();
      if (user != null) {
        return Right(user);
      }
      return const Left(FirebaseFailure("Auth Failure"));
    } on AuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        return Right(user);
      }
      return const Left(FirebaseFailure("Auth Failure"));
    } on AuthException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOutFirebase() async {
    try {
      await _authService.signOutFirebase();
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmail(String newEmail) async {
    try {
      await _authService.updateEmail(newEmail);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
