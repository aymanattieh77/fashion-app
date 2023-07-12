// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fashion_app/data/remote/firebase_database/firebase_address_service.dart';

import '../../domain/entities/account/address.dart';

abstract class AddressRemoteDataSource {
  Future<void> addAddress(AddressEntity address);
  Future<DocumentSnapshot<Map<String, dynamic>>> getSavedAddress();
  Future<AddressEntity?> deleteAddress(int index);
  Future<void> updateAddress(AddressEntity address);
  Future<void> clearAddress();
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final FirebaseAddressService _addressService;
  AddressRemoteDataSourceImpl(this._addressService);
  @override
  Future<void> addAddress(AddressEntity address) async {
    return await _addressService.addAddress(address);
  }

  @override
  Future<void> clearAddress() async {
    return await _addressService.clearAddress();
  }

  @override
  Future<AddressEntity?> deleteAddress(int id) async {
    return await _addressService.deleteAddress(id);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getSavedAddress() async {
    return await _addressService.getSavedAddress();
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    return await _addressService.updateAddress(address);
  }
}
