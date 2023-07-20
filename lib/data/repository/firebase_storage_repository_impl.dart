import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/core/errors/failure.dart';

import 'package:fashion_app/data/data_source/storage_remote_data_soruce.dart';

import 'package:fashion_app/domain/repository/repositories.dart';

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  final StorageRemoteDataSource _source;
  FirebaseStorageRepositoryImpl(this._source);
  @override
  Future<Either<Failure, String>> uploadAnImage(File file) async {
    try {
      return Right(await _source.uploadAnImage(file));
    } on FireException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }
}
