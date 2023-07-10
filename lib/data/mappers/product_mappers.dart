import 'package:fashion_app/data/models/product/product_detail_model.dart';
import 'package:fashion_app/data/models/product/product_model.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';

extension ProdcutModelExtensions on ProductModel {
  ProductEntity toDomain() {
    return ProductEntity(
      id: id ?? 0,
      name: name ?? "",
      price: price ?? 0.0,
      currency: currency ?? "USD",
      brandName: brandName ?? "",
      colour: colour ?? "",
      productCode: productCode ?? 0,
      url: url ?? "",
      imageUrl: fixImagePath(),
      additionalImageUrls: additionalImageUrls ?? <String>[],
    );
  }

  String fixImagePath() {
    if (imageUrl != null) {
      return 'https://${imageUrl!}';
    } else {
      return "";
    }
  }
}

extension ProductDetailModelExtension on ProductDetailModel {
  ProductDetailEntity toDomain() {
    return ProductDetailEntity(
      id: id ?? 0,
      name: name ?? "",
      description: description ?? "",
      categoryName: categoryName ?? "",
      gender: gender ?? "",
      productCode: productCode ?? "",
      brand: brand ?? "",
      images: fixImagesPath(),
      currentPrice: currentPrice ?? 0.0,
      previousPrice: previousPrice ?? 0.0,
      currency: currency ?? "USD",
      startDateTime: startDateTime ?? "",
    );
  }

  List<String> fixImagesPath() {
    if (images != null) {
      return images!.map((e) => 'https://${e.toString()}').toList();
    } else {
      return <String>[];
    }
  }
}
