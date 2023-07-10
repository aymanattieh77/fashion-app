import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_user_service.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

abstract class UserRemoteDataSource {
  Future<void> createUserProfile(UserModel user);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById();
  Future<void> updateUserProfile(UserModel user);
  Future<void> deleteUserProfile();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseUserService _service;
  UserRemoteDataSourceImpl(this._service);
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById() async {
    return _service.getUserProfileById();
  }

  @override
  createUserProfile(UserModel accountModel) async {
    await _service.createUserProfile(accountModel);
  }

  @override
  Future<void> deleteUserProfile() async {
    return await _service.deleteUserProfile();
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    return await _service.updateUserProfile(user);
  }
}
