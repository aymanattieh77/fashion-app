// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/data/data_source/user_remote_data_source.dart';

import 'package:fashion_app/domain/entities/account/user.dart';

import '../../domain/repository/repositories.dart';

class FirebaseUserRepositoryImpl implements FirebaseUserRepository {
  final UserRemoteDataSource _dataSource;
  FirebaseUserRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, UserModel>> getUserProfileById() async {
    try {
      final doc = await _dataSource.getUserProfileById();

      if (doc.exists && doc.data() != null) {
        return Right(UserModel.fromMap(doc.data()!));
      }
      return const Left(FirebaseFailure("User Not Exist"));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createUserProfile(UserModel user) async {
    try {
      final doc = await _dataSource.getUserProfileById();
      if (doc.exists) {
        return const Left(FirebaseFailure('User Already Exist'));
      }
      await _dataSource.createUserProfile(user);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile() async {
    try {
      await _dataSource.deleteUserProfile();
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(UserModel user) async {
    try {
      await _dataSource.updateUserProfile(user);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
