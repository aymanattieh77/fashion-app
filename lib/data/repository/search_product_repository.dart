import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/core/errors/server_failure.dart';
import 'package:fashion_app/core/network_info/network_info.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/data/data_source/product_remote_data_source.dart';
import 'package:fashion_app/data/mappers/product_mappers.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show SearchProductRepository;

class SearchProductRepositoryImpl implements SearchProductRepository {
  final ProductRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  SearchProductRepositoryImpl(this._remote, this._networkInfo);
  @override
  Future<Either<Failure, List<ProductEntity>>> getProdcutsBySearch(
      {int? offset,
      String? sort,
      int? priceMin,
      int? priceMax,
      required String q}) async {
    if (!await _networkInfo.isConnected) {
      return const Left(ServerFailure(AppStrings.internetConnectionError));
    }
    try {
      final response = await _remote.getProdcutsBySearch(
        offset: offset,
        sort: sort,
        priceMax: priceMax,
        priceMin: priceMin,
        q: q,
      );
      if (response.products != null && response.products!.isNotEmpty) {
        return Right(response.products!.map((e) => e.toDomain()).toList());
      }
      return const Right([]);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
