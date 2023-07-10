import 'package:fashion_app/data/models/product/product_model.dart';

class ProductResponse {
  final String? categoryName;
  final int? itemCount;
  final List<ProductModel>? products;
  ProductResponse({
    this.categoryName,
    this.itemCount,
    this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      categoryName:
          json['categoryName'] != null ? json['categoryName'] as String : null,
      itemCount: json['itemCount'] != null ? json['itemCount'] as int : null,
      products: json['products'] != null
          ? List<ProductModel>.from(
              (json['products'] as List).map(
                (x) => ProductModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
