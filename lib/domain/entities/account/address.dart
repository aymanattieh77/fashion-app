import 'package:fashion_app/core/utils/strings.dart';

enum AddressType { apartment, house, office }

extension AddressTypeEx on AddressType {
  String get addressType {
    switch (this) {
      case AddressType.apartment:
        return AppStrings.apartment;
      case AddressType.house:
        return AppStrings.house;
      case AddressType.office:
        return AppStrings.office;
    }
  }
}

class Address {
  final List<AddressEntity> address;
  Address(this.address);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address.map((x) => x.toMap()).toList(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      List<AddressEntity>.from(
        (map['address'] as List<dynamic>).map<AddressEntity>(
          (x) => AddressEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class AddressEntity {
  final int id;
  final String streetName;
  final String? additionalDirections;
  final String phoneNumber;
  final AddressLocationEntity? addressLocation;
  final String addressType;
  final int? buildingNumber;
  final int? floor;
  final int? houseNumber;
  final int? companyNumber;
  final String? companyName;

  const AddressEntity({
    required this.id,
    required this.streetName,
    this.additionalDirections,
    this.companyNumber,
    required this.phoneNumber,
    this.addressLocation,
    required this.addressType,
    this.buildingNumber,
    this.floor,
    this.houseNumber,
    this.companyName,
  });
  AddressEntity copyWith({
    String? streetName,
    String? additionalDirections,
    String? phoneNumber,
    String? addressType,
    AddressLocationEntity? addressLocation,
    int? buildingNumber,
    int? companyNumber,
    int? floor,
    int? houseNumber,
    String? companyName,
  }) {
    return AddressEntity(
      id: id,
      streetName: streetName ?? this.streetName,
      additionalDirections: additionalDirections ?? this.additionalDirections,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressType: addressType ?? this.addressType,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      floor: floor ?? this.floor,
      addressLocation: addressLocation ?? this.addressLocation,
      companyNumber: companyNumber ?? this.companyNumber,
      houseNumber: houseNumber ?? this.houseNumber,
      companyName: companyName ?? this.companyName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'streetName': streetName,
      'additionalDirections': additionalDirections,
      'phoneNumber': phoneNumber,
      'addressLocation': addressLocation?.toMap(),
      'addressType': addressType,
      'buildingNumber': buildingNumber,
      'companyNumber': companyNumber,
      'floor': floor,
      'houseNumber': houseNumber,
      'companyName': companyName,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id'] as int,
      streetName: map['streetName'] as String,
      additionalDirections: map['additionalDirections'] != null
          ? map['additionalDirections'] as String
          : null,
      phoneNumber: map['phoneNumber'] as String,
      addressLocation: map['addressLocation'] != null
          ? AddressLocationEntity.fromMap(
              map['addressLocation'] as Map<String, dynamic>)
          : null,
      addressType: map['addressType'] as String,
      buildingNumber:
          map['buildingNumber'] != null ? map['buildingNumber'] as int : null,
      companyNumber:
          map['companyNumber'] != null ? map['companyNumber'] as int : null,
      floor: map['floor'] != null ? map['floor'] as int : null,
      houseNumber:
          map['houseNumber'] != null ? map['houseNumber'] as int : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
    );
  }

  @override
  bool operator ==(covariant AddressEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.streetName == streetName &&
        other.additionalDirections == additionalDirections &&
        other.phoneNumber == phoneNumber &&
        other.addressLocation == addressLocation &&
        other.addressType == addressType &&
        other.buildingNumber == buildingNumber &&
        other.floor == floor &&
        other.houseNumber == houseNumber &&
        other.companyNumber == companyNumber &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        streetName.hashCode ^
        additionalDirections.hashCode ^
        phoneNumber.hashCode ^
        addressLocation.hashCode ^
        addressType.hashCode ^
        buildingNumber.hashCode ^
        floor.hashCode ^
        houseNumber.hashCode ^
        companyNumber.hashCode ^
        companyName.hashCode;
  }
}

class AddressLocationEntity {
  final double lat;
  final double log;
  final String country;
  final String state;
  final String city;
  final String street;
  AddressLocationEntity({
    required this.lat,
    required this.log,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
  });

  AddressLocationEntity copyWith({
    double? lat,
    double? log,
    String? country,
    String? state,
    String? city,
    String? street,
  }) {
    return AddressLocationEntity(
      lat: lat ?? this.lat,
      log: log ?? this.log,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'log': log,
      'country': country,
      'state': state,
      'city': city,
      'street': street,
    };
  }

  static AddressLocationEntity fromMap(Map<String, dynamic> map) {
    return AddressLocationEntity(
      lat: map['lat'] as double,
      log: map['log'] as double,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      street: map['street'] as String,
    );
  }
}
