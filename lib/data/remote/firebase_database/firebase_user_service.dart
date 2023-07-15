import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

abstract class FirebaseUserService {
  Future<void> createUserProfile(UserModel user, String userUid);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById(
      String userUid);
  Future<void> updateUserProfile(UserModel user, String userUid);
  Future<void> deleteUserProfile(String userUid);
}

class FirebaseUserServiceImpl implements FirebaseUserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  createUserProfile(UserModel user, String userUid) async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userUid)
        .set(user.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById(
      String userUid) async {
    return await firestore
        .collection(AppConstants.usersCollection)
        .doc(userUid)
        .get();
  }

  @override
  updateUserProfile(UserModel user, String userUid) async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userUid)
        .update(user.toMap());
  }

  @override
  deleteUserProfile(userUid) async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userUid)
        .delete();
  }
}
