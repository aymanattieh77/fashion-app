import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_user_service.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

abstract class UserRemoteDataSource {
  Future<void> createUserProfile(UserModel user, String userUid);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById(
      String userUid);
  Future<void> updateUserProfile(UserModel user, String userUid);
  Future<void> deleteUserProfile(String userUid);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseUserService _service;
  UserRemoteDataSourceImpl(this._service);
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById(
      String userUid) async {
    return _service.getUserProfileById(userUid);
  }

  @override
  createUserProfile(UserModel accountModel, String userUid) async {
    await _service.createUserProfile(accountModel, userUid);
  }

  @override
  Future<void> deleteUserProfile(String userUid) async {
    return await _service.deleteUserProfile(userUid);
  }

  @override
  Future<void> updateUserProfile(UserModel user, String userUid) async {
    return await _service.updateUserProfile(user, userUid);
  }
}
