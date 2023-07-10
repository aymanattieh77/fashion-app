import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/core/utils/constants.dart';

import '../../../domain/entities/account/address.dart';

abstract class FirebaseAddressService {
  Future<void> addAddress(AddressEntity address);
  Future<DocumentSnapshot<Map<String, dynamic>>> getSavedAddress();
  Future<AddressEntity?> deleteAddress(int id);
  Future<void> updateAddress(AddressEntity address);
  Future<void> clearAddress();
}

class FirebaseAddressServiceImpl implements FirebaseAddressService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userId = getIt<AppPrefs>().userUid;
  @override
  Future<void> addAddress(AddressEntity address) async {
    final doc = await firestore
        .collection(AppConstants.addressCollection)
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      final addressModel = Address.fromMap(doc.data()!);

      addressModel.address.add(address);
      await firestore
          .collection('address')
          .doc(userId)
          .set(addressModel.toMap());
    } else {
      await firestore
          .collection('address')
          .doc(userId)
          .set(Address([address]).toMap());
    }
  }

  @override
  Future<void> clearAddress() async {
    await firestore.collection('address').doc(userId).delete();
  }

  @override
  Future<AddressEntity?> deleteAddress(int index) async {
    final doc = await firestore
        .collection(AppConstants.addressCollection)
        .doc(userId)
        .get();
    if (doc.exists && doc.data() != null) {
      final address = Address.fromMap(doc.data()!).address;
      final deleteAddress = address.removeAt(index);

      await firestore
          .collection('address')
          .doc(userId)
          .set(Address(address).toMap());

      return deleteAddress;
    }
    return null;
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getSavedAddress() async {
    return await firestore
        .collection(AppConstants.addressCollection)
        .doc(userId)
        .get();
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    final doc = await firestore
        .collection(AppConstants.addressCollection)
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      final addressList = Address.fromMap(doc.data()!).address;
      int index = addressList.indexWhere((element) => element.id == address.id);
      if (index != -1) {
        addressList[index] = address;
        await firestore
            .collection(AppConstants.addressCollection)
            .doc(userId)
            .update(Address(addressList).toMap());
      }
    }
  }
}
