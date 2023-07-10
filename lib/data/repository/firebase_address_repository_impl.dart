import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/data/data_source/address_remote_data_source.dart';
import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:fashion_app/domain/repository/repositories.dart';

class FirebaseAddressRepositoryImpl implements FirebaseAddressRepository {
  final AddressRemoteDataSource _dataSource;
  FirebaseAddressRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, void>> addAddress(AddressEntity addressEntity) async {
    try {
      await _dataSource.addAddress(addressEntity);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearAddress() async {
    try {
      await _dataSource.clearAddress();
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressEntity?>> deleteAddress(int index) async {
    try {
      final deletedAddress = await _dataSource.deleteAddress(index);
      return Right(deletedAddress);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getSavedAddress() async {
    try {
      final result = await _dataSource.getSavedAddress();
      if (result.exists && result.data() != null) {
        return Right(Address.fromMap(result.data()!).address);
      } else {
        return const Left(FirebaseFailure("address faild"));
      }
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAddress(
      AddressEntity addressEntity) async {
    try {
      await _dataSource.updateAddress(addressEntity);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
