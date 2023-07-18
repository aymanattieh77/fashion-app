// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final String currency;
  final String brandName;
  final String colour;
  final int productCode;
  final String url;
  final String imageUrl;
  final List<String> additionalImageUrls;
  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.brandName,
    required this.colour,
    required this.productCode,
    required this.url,
    required this.imageUrl,
    required this.additionalImageUrls,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      price,
      currency,
      brandName,
      colour,
      productCode,
      url,
      imageUrl,
      additionalImageUrls,
    ];
  }
}
