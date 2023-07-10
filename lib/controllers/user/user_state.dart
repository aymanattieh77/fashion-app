part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFailure extends UserState {}

class UserCreated extends UserState {}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}

class UserLoaded extends UserState {}
