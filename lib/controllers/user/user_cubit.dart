import 'package:equatable/equatable.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
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

  UserModel? user;

  // read
  getUserProfileById() async {
    (await _getUsecase.call(const NoParameters())).fold(
      (failure) {
        showToastMessage(failure.message);
        emit(UserFailure());
      },
      (userModel) {
        user = userModel;
        emit(UserLoaded());
      },
    );
  }

  // create
  Future<void> createUserprofile(UserModel entity) async {
    (await _saveUsecase.call(entity)).fold(
      (failure) {
        showToastMessage(failure.message);
        emit(UserFailure());
      },
      (r) {
        emit(UserCreated());
      },
    );
  }

// delete
  deleteUserProfile() async {
    (await _deleteUsecase.call(const NoParameters())).fold(
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
    if (user != null) {
      final newUser = user!.copyWith(
        username: username,
        email: email,
        phoneNumber: phone,
      );
      if (email != null) {
        await BlocProvider.of<AuthCubit>(context).updateEmail(context, email);
      }

      (await _updateusecase.call(newUser)).fold(
        (failure) {
          showToastMessage(failure.message);
          emit(UserFailure());
        },
        (r) {
          emit(UserUpdated());
          getUserProfileById();
        },
      );
    }

    showToastMessage('User Profile Updated');
    // ignore: use_build_context_synchronously
    context.back();
    // ignore: use_build_context_synchronously
  }

  UserModel? get getUser {
    if (user != null) {
      return user!.toDomain();
    }
    return null;
  }
}
