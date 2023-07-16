import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/data/remote/firebase_storage/storage_service.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._storageService) : super(ProfileInitial());
  final StorageService _storageService;

  Future<String?> _uploadAnImage(File file) async {
    try {
      return await _storageService.uploadAnImage(file);
    } on FireException catch (e) {
      emit(ProfileFailure());
      showToastMessage(e.message);
    }
    return null;
  }

  updateProfilePicture(BuildContext context) {
    showCustomDialog(
      context,
      CustomAlertDialog(
        message: "Pick an image from Camera or Gallery!",
        cancelText: 'Camera',
        confirmText: 'Gallery',
        onCancel: () {
          _pickImage(context, ImageSource.camera);
        },
        onConfirm: () {
          _pickImage(context, ImageSource.gallery);
        },
      ),
    );
  }

  _pickImage(BuildContext context, ImageSource imageSource) async {
    final file = await pickImage(imageSource);
    // ignore: use_build_context_synchronously
    context.back();
    if (file != null) {
      final imagePath = await _uploadAnImage(file);
      // ignore: use_build_context_synchronously
      updateUserProfilePhoto(context, imagePath);
    }

    return;
  }

  updateUserProfilePhoto(BuildContext context, String? photo) {
    BlocProvider.of<UserCubit>(context).updateUserProfile(
      context,
      profilePhoto: photo,
    );
  }
}
