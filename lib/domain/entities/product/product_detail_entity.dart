import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String categoryName;
  final String gender;
  final String productCode;
  final String brand;
  final List<String> images;
  final double currentPrice;
  final double previousPrice;
  final String currency;
  final String startDateTime;
  const ProductDetailEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.gender,
    required this.productCode,
    required this.brand,
    required this.images,
    required this.currentPrice,
    required this.previousPrice,
    required this.currency,
    required this.startDateTime,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      categoryName,
      gender,
      productCode,
      brand,
      images,
      currentPrice,
      previousPrice,
      currency,
      startDateTime,
    ];
  }
}
