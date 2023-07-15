import 'package:fashion_app/data/models/product/product_detail_model.dart';
import 'package:fashion_app/data/models/product/product_response.dart';
import 'package:fashion_app/data/remote/product/product_service.dart';

abstract class ProductRemoteDataSource {
  Future<ProductDetailModel> getProdcutDetail({required int productId});

  Future<ProductResponse> getProdcutsByCategoryId(
      {required int categoryId,
      int? limit,
      String? sort,
      int? priceMin,
      int? priceMax,
      int? offset});

  Future<ProductResponse> getProdcutsBySearch(
      {required String? q,
      int? limit,
      String? sort,
      int? priceMin,
      int? priceMax,
      int? offset});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductService _productService;

  ProductRemoteDataSourceImpl(this._productService);
  @override
  Future<ProductDetailModel> getProdcutDetail({required int productId}) async {
    return await _productService.getProdcutDetail(id: productId);
  }

  @override
  Future<ProductResponse> getProdcutsByCategoryId({
    required int categoryId,
    int? limit,
    String? sort,
    int? priceMin,
    int? priceMax,
    String? q,
    int? offset,
  }) async {
    Map<String, dynamic> queriesParameters = {
      'categoryId': categoryId,
      'limit': limit ?? 15,
      'store': "US",
      'offset': offset ?? 0,
      'sort': sort ?? "freshness",
      'currency': "USD",
      'sizeSchema': "US",
      'lang': " en-US",
    };
    if (priceMin != null) {
      queriesParameters['priceMin'] = priceMin;
    }
    if (priceMax != null) {
      queriesParameters['priceMax'] = priceMax;
    }
    if (q != null) {
      queriesParameters['q'] = q;
    }
    return await _productService.getProdcuts(
      queriesParameters: queriesParameters,
    );
  }

  @override
  Future<ProductResponse> getProdcutsBySearch({
    required String? q,
    int? limit,
    String? sort,
    int? priceMin,
    int? priceMax,
    int? offset,
  }) async {
    Map<String, dynamic> queriesParameters = {
      'q': q,
      'limit': limit ?? 20,
      'store': "US",
      'offset': offset ?? 0,
      'sort': sort ?? "freshness",
      'currency': "USD",
      'sizeSchema': "US",
      'lang': " en-US",
    };
    if (priceMin != null) {
      queriesParameters['priceMin'] = priceMin;
    }
    if (priceMax != null) {
      queriesParameters['priceMax'] = priceMax;
    }

    return await _productService.getProdcuts(
      queriesParameters: queriesParameters,
    );
  }
}
