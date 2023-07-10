import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

abstract class FirebaseUserService {
  Future<void> createUserProfile(UserModel user);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById();
  Future<void> updateUserProfile(UserModel user);
  Future<void> deleteUserProfile();
}

class FirebaseUserServiceImpl implements FirebaseUserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userId = getIt<AppPrefs>().userUid;
  @override
  createUserProfile(UserModel user) async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .set(user.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileById() async {
    return await firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();
  }

  @override
  updateUserProfile(UserModel user) async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update(user.toMap());
  }

  @override
  deleteUserProfile() async {
    await firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .delete();
  }
}
