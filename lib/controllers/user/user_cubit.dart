import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/domain/entities/account/user.dart';
import 'package:fashion_app/domain/usecases/user/delete_user_profile_usecase.dart';
import 'package:fashion_app/domain/usecases/user/get_user_profile_by_id_usecase.dart';
import 'package:fashion_app/domain/usecases/user/save_user_profile_usecase.dart';
import 'package:fashion_app/domain/usecases/user/update_user_profile_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._getUsecase, this._saveUsecase, this._deleteUsecase,
      this._updateusecase)
      : super(UserInitial());

  final GetUserProfileByIdUseCase _getUsecase;
  final UpdateUserProfileUsecase _updateusecase;
  final DeleteUserProfileUsecase _deleteUsecase;
  final SaveUserProfileUsecase _saveUsecase;

  UserModel? _user;

  UserModel? get user {
    if (_user != null) {
      return _user!.toDomain();
    } else {
      return null;
    }
  }

  // read
  getUserProfileById(String userUid) async {
    (await _getUsecase.call(userUid)).fold(
      (failure) {
        //   showToastMessage(failure.message);
        emit(UserFailure());
      },
      (userModel) {
        _user = userModel;
        emit(UserLoaded());
      },
    );
  }

  // create
  Future<void> createUserprofile(UserModel entity, String userUid) async {
    (await _saveUsecase.call(SaveUserInputs(entity, userUid))).fold(
      (failure) {
        //showToastMessage(failure.message);
        emit(UserFailure());
      },
      (r) {
        emit(UserCreated());
      },
    );
  }

// delete
  deleteUserProfile(String userUid) async {
    (await _deleteUsecase.call(userUid)).fold(
      (failure) {
        showToastMessage(failure.message);
        emit(UserFailure());
      },
      (r) {
        emit(UserDeleted());
      },
    );
  }

  // update
  updateUserProfile(BuildContext context,
      {String? username,
      String? email,
      String? phone,
      String? location,
      String? zipcode}) async {
    if (_user != null) {
      final newUser = _user!.copyWith(
        username: username,
        email: email,
        phoneNumber: phone,
        location: location,
        zipCode: zipcode,
      );
      if (email != null && email.isNotEmpty) {
        BlocProvider.of<AuthCubit>(context).updateEmail(context, email);
      }
      (await _updateusecase.call(UpdateUserInputs(newUser, newUser.uid))).fold(
        (failure) {
          showToastMessage(failure.message);
          emit(UserFailure());
        },
        (r) {
          emit(UserUpdated());
          getUserProfileById(newUser.uid);
        },
      );
    }

    showToastMessage('User Profile Updated');
    // ignore: use_build_context_synchronously
    context.back();
  }
}
