part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressFailure extends AddressState {
  final String message;
  AddressFailure(this.message);
}

class AddressUpdated extends AddressState {}

class AddressLoaded extends AddressState {}
