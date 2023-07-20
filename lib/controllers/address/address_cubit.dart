import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/map/map_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/view/delivery/pages/custom_google_map.dart';
import 'package:fashion_app/view/delivery/pages/edit_address_page.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._repository) : super(AddressInitial());

  final bNum = TextEditingController();
  final additional = TextEditingController();
  final floor = TextEditingController();
  final street = TextEditingController();
  final phone = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final FirebaseAddressRepository _repository;

  int currentAddressType = 0;
  List<AddressEntity> addressList = [];

  static AddressCubit getCubit(BuildContext context) =>
      BlocProvider.of<AddressCubit>(context);

  AddressLocationEntity addressLocation = AddressLocationEntity(
    lat: 0,
    log: 0,
    country: AppStrings.conutry,
    state: AppStrings.state,
    city: AppStrings.city,
    street: AppStrings.street,
  );

  void start(AddressEntity? address) {
    if (address != null) {
      bNum.text = address.buildingNumber.toString();
      street.text = address.streetName;
      phone.text = address.phoneNumber;
      floor.text = address.floor.toString();
      additional.text = address.additionalDirections.toString();
      currentAddressType = getCurrentAddressType(address.addressType);
      return;
    }
    bNum.clear();
    street.clear();
    phone.clear();
    floor.clear();
    additional.clear();
    currentAddressType = 0;
  }

  void onAddressTypeChange(index) {
    currentAddressType = index;
    emit(AddressInitial());
  }

  void updateAddressLocation(AddressLocationEntity loc) {
    addressLocation = loc;
    emit(AddressUpdated());
  }

  Future<void> getSavedAddress() async {
    emit(AddressLoading());
    // Get all Address from firebase

    (await _repository.getSavedAddress()).fold(
      (failure) {
        emit(AddressFailure(failure.message));
      },
      (address) {
        addressList = address;
        emit(AddressLoaded());
      },
    );
  }

  Future<void> addAddress(AddressEntity address) async {
    // add address to firebase

    (await _repository.addAddress(address)).fold(
      (failure) {
        emit(AddressFailure(failure.message));
      },
      (r) {
        addressList.add(address);

        emit(AddressLoaded());
      },
    );
  }

  Future<AddressEntity?> _deleteAddress(int index) async {
    (await _repository.deleteAddress(index)).fold(
      (failure) {
        emit(AddressFailure(failure.message));
      },
      (r) {
        addressList.removeAt(index);
        emit(AddressLoaded());
        return r;
      },
    );
    return null;
  }

  Future<void> updateAddress(AddressEntity address) async {
    //  update Address from Firebase
    final index = addressList.indexWhere((element) => element.id == address.id);
    (await _repository.updateAddress(address)).fold(
      (failure) {
        emit(AddressFailure(failure.message));
        showToastMessage("Feilad update address");
      },
      (r) {
        addressList[index] = address;
        emit(AddressLoaded());
      },
    );
  }

  Future<void> clearAddress() async {
    //  clear all Address from Firebase
    (await _repository.clearAddress()).fold(
      (failure) {
        emit(AddressFailure(failure.message));
      },
      (r) {
        addressList.clear();
        emit(AddressLoaded());
      },
    );
  }

  void save(BuildContext context, AddressEntity? address) {
    if (!globalKey.currentState!.validate()) {
      return;
    }

    address == null ? _add() : _update(address);
    context.back();
  }

  void _add() {
    final address = AddressEntity(
      id: DateTime.now().microsecondsSinceEpoch,
      streetName: street.text,
      buildingNumber: int.tryParse(bNum.text),
      phoneNumber: phone.text,
      additionalDirections: additional.text,
      addressLocation: addressLocation,
      floor: int.tryParse(floor.text),
      companyNumber: int.tryParse(bNum.text),
      houseNumber: int.tryParse(bNum.text),
      companyName: bNum.text,
      addressType: getAddressType().addressType,
    );
    addAddress(address);
  }

  void _update(AddressEntity address) {
    final newAddress = address.copyWith(
      addressType: getAddressType().addressType,
      streetName: street.text,
      buildingNumber: int.tryParse(bNum.text),
      phoneNumber: phone.text,
      additionalDirections: additional.text,
      addressLocation: addressLocation,
      floor: int.tryParse(floor.text),
      companyNumber: int.tryParse(bNum.text),
      houseNumber: int.tryParse(bNum.text),
      companyName: bNum.text,
    );
    updateAddress(newAddress);
  }

  void delete(BuildContext context, int index) {
    showCustomDialog(
      context,
      CustomAlertDialog(
        message: 'Are you sure delete address',
        onCancel: () {
          dismissDialog(context);
        },
        onConfirm: () async {
          await _deleteAddress(index);
          // ignore: use_build_context_synchronously
          dismissDialog(context);
        },
      ),
    );
  }

  int getCurrentAddressType(String addressType) {
    switch (addressType) {
      case AppStrings.apartment:
        return 0;
      case AppStrings.house:
        return 1;
      case AppStrings.office:
        return 2;
      default:
        return 0;
    }
  }

  AddressType getAddressType() {
    switch (currentAddressType) {
      case 0:
        return AddressType.apartment;
      case 1:
        return AddressType.house;
      case 2:
        return AddressType.office;

      default:
        return AddressType.apartment;
    }
  }

  String get addressHint1 {
    switch (currentAddressType) {
      case 0:
        return AppStrings.buildingNum;
      case 1:
        return AppStrings.houseNum;
      case 2:
        return AppStrings.companyNum;
      default:
        return AppStrings.buildingNum;
    }
  }

  void pickLocation(BuildContext context) {
    context.goTo(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapCubit(getIt()),
          ),
          BlocProvider.value(value: getCubit(context)),
        ],
        child: const CustomGoogleMap(),
      ),
    );
  }

  void goToEditAddressPage(BuildContext context,
      [AddressEntity? addressEntity]) {
    context.goTo(
      BlocProvider.value(
        value: getCubit(context),
        child: EditAddressPage(address: addressEntity),
      ),
    );
  }

  void dispose() {
    bNum.dispose();
    street.dispose();
    phone.dispose();
    additional.dispose();
    floor.dispose();
  }
}
