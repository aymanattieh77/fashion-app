import 'dart:io';

import 'package:fashion_app/data/remote/firebase_storage/storage_service.dart';

abstract class StorageRemoteDataSource {
  Future<String> uploadAnImage(File file);
}

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final StorageService _service;
  StorageRemoteDataSourceImpl(this._service);
  @override
  Future<String> uploadAnImage(File file) async {
    return await _service.uploadAnImage(file);
  }
}
