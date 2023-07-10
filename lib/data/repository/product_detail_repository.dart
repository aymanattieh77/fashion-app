import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/core/errors/server_failure.dart';
import 'package:fashion_app/core/network_info/network_info.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/data/data_source/product_remote_data_source.dart';
import 'package:fashion_app/data/mappers/product_mappers.dart';

import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show ProductDetailRepository;

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  ProductDetailRepositoryImpl(this._remote, this._networkInfo);
  @override
  Future<Either<Failure, ProductDetailEntity>> getProdcutDetail(
      {required int productId}) async {
    if (!await _networkInfo.isConnected) {
      return const Left(ServerFailure(AppStrings.internetConnectionError));
    }
    try {
      final response = await _remote.getProdcutDetail(productId: productId);
      return Right(response.toDomain());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
