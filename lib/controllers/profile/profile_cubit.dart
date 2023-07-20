// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fashion_app/domain/usecases/usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/permissions.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';

import 'package:fashion_app/core/utils/utils.dart';

import 'package:fashion_app/view/auth/widgets/custom_input_field.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._uploadImageUsecase, this._updateEmailUsecase,
      this._reAuthenticatesUser)
      : super(ProfileInitial());
  final UploadImageUsecase _uploadImageUsecase;
  final UpdateEmailUsecase _updateEmailUsecase;
  final ReAuthenticatesUserUsecase _reAuthenticatesUser;
  final permissions = getIt<AppPermissions>();
  String? image;
  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final location = TextEditingController();
  final zipcode = TextEditingController();
  final password = TextEditingController();

  start(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    if (cubit.user != null) {
      username.text = cubit.user!.username;
      email.text = cubit.user!.email;
      phone.text = cubit.user!.phoneNumber ?? "";
      location.text = cubit.user!.location ?? "";
      zipcode.text = cubit.user!.zipCode ?? "";
    }
  }

  pickImageFromCameraOrGallery(BuildContext context) async {
    await showCustomDialog(
      context,
      CustomAlertDialog(
        message: AppStrings.pickImageGalleryCamera,
        cancelText: AppStrings.camera,
        confirmText: AppStrings.gallery,
        onCancel: () {
          _requsetImageSource(context, ImageSource.camera);
        },
        onConfirm: () {
          _requsetImageSource(context, ImageSource.gallery);
        },
      ),
    );
  }

  Future<void> updateUserProfile(BuildContext context) async {
    final cubit = BlocProvider.of<UserCubit>(context);

    if (email.text.isNotEmpty && email.text.isValidEmail) {
      (await _updateEmailUsecase.call(email.text)).fold(
        (failure) async {
          showToastMessage(failure.message);
          await _reLoginUserAccounnt(context);
          return;
        },
        (_) async {
          await cubit.updateUserProfile(
            context,
            username: username.text,
            email: email.text,
            phone: phone.text,
            location: location.text,
            zipcode: zipcode.text,
            profilePhoto: image,
          );
          emit(ProfileUpdated());
        },
      );
    }
    return;
  }

  String profileImage(BuildContext context) {
    final userImage = BlocProvider.of<UserCubit>(context).user?.profilePhoto ??
        AppConstants.profilePicturePlaceholder;
    return image ?? userImage;
  }

  _requsetImageSource(BuildContext context, ImageSource source) async {
    final bool isGrand = source == ImageSource.gallery
        ? await permissions.requestPhotosPermission()
        : await permissions.requestCameraPermission();

    if (isGrand) {
      _pickImage(context, source);
    } else {
      permissions.openSettings();
    }
  }

  _pickImage(BuildContext context, ImageSource imageSource) async {
    // pick image from gallery or camera
    final file = await pickImage(imageSource);

    dismissDialog(context);
    if (file != null) {
      // store image path in firebase storage
      final imagePath = await _uploadAnImageFirebaseStorage(file);

      image = imagePath;
      emit(ProfileUpdated());
    }

    return;
  }

  Future<String?> _uploadAnImageFirebaseStorage(File file) async {
    return (await _uploadImageUsecase.call(file)).fold(
      (failure) {
        emit(ProfileFailure());
        showToastMessage(failure.message);
        return null;
      },
      (filepath) {
        return filepath;
      },
    );
  }

  _reLoginUserAccounnt(BuildContext context) async {
    showCustomDialog(
      context,
      CustomAlertDialog(
        message: AppStrings.reLogin,
        content: CustomInputField(
          icon: AssetsIconPath.lock,
          hint: AppStrings.password,
          controller: password,
          filedType: FieldType.text,
        ),
        cancelText: AppStrings.cancel,
        confirmText: AppStrings.login,
        onCancel: () {
          context.back();
        },
        onConfirm: () async {
          await _reAuthenticateUser();
        },
      ),
    );
  }

  _reAuthenticateUser() async {
    (await _reAuthenticatesUser
            .call(LoginUsecaseInputs(email.text, password.text)))
        .fold(
      (failure) {
        showToastMessage(failure.message);
        emit(ProfileFailure());
      },
      (_) {
        emit(ProfileReAuthenticate());
      },
    );
  }

  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    location.dispose();
    zipcode.dispose();
    password.dispose();
  }
}
