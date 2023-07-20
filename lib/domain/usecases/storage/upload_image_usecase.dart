import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class UploadImageUsecase implements BaseUsecase<String, File> {
  final FirebaseStorageRepository _repository;
  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(File parameters) async {
    return await _repository.uploadAnImage(parameters);
  }
}
