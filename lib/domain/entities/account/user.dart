import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/core/utils/strings.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String profilePhoto;
  final String? location;
  final String? zipCode;
  final String? phoneNumber;
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePhoto,
    this.location,
    this.zipCode,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'profilePhoto': profilePhoto,
      'location': location ?? "",
      'zipCode': zipCode ?? "",
      'phoneNumber': phoneNumber ?? "",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePhoto: map['profilePhoto'] as String,
      location: map['location'] as String?,
      zipCode: map['zipCode'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
    );
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? profilePhoto,
    String? location,
    String? zipCode,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      location: location ?? this.location,
      zipCode: zipCode ?? this.zipCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

extension UserModelEx on UserModel {
  UserModel toDomain() {
    return UserModel(
      uid: uid,
      username: username,
      email: email,
      location: location!.isEmpty ? AppStrings.location.tr() : location,
      phoneNumber:
          phoneNumber!.isEmpty ? AppStrings.phoneNumber.tr() : phoneNumber,
      profilePhoto: profilePhoto,
      zipCode: zipCode!.isEmpty ? AppStrings.zipcode.tr() : zipCode,
    );
  }
}
