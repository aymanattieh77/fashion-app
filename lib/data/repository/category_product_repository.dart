import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/core/errors/server_failure.dart';
import 'package:fashion_app/core/network_info/network_info.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/data/data_source/product_remote_data_source.dart';
import 'package:fashion_app/data/mappers/product_mappers.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart'
    show CategoryProductRepository;

class CategoryProductRepositoryImpl implements CategoryProductRepository {
  final ProductRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  CategoryProductRepositoryImpl(this._remote, this._networkInfo);
  @override
  Future<Either<Failure, List<ProductEntity>>> getProdcutsByCategoryId({
    required int categoryId,
    String? sort,
    int? offset,
    int? priceMin,
    int? priceMax,
  }) async {
    if (!await _networkInfo.isConnected) {
      // has no internet
      return const Left(ServerFailure(AppStrings.internetConnectionError));
    }
    try {
      final response = await _remote.getProdcutsByCategoryId(
        categoryId: categoryId,
        limit: AppConstants.categoryProductsLimit,
        sort: sort,
        offset: offset,
        priceMax: priceMax,
        priceMin: priceMin,
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
