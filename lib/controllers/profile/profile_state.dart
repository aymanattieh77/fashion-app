part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileFailure extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileReAuthenticate extends ProfileState {}
