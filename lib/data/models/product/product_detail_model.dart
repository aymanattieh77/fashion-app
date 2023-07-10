class ProductDetailModel {
  final int? id;
  final String? name;
  final String? description;
  final String? categoryName;
  final String? gender;
  final String? productCode;
  final String? brand;
  final List<String>? images;
  final double? currentPrice;
  final double? previousPrice;
  final String? currency;
  final String? startDateTime;
  ProductDetailModel({
    this.id,
    this.name,
    this.description,
    this.categoryName,
    this.gender,
    this.productCode,
    this.brand,
    this.images,
    this.currentPrice,
    this.previousPrice,
    this.currency,
    this.startDateTime,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryName: json['productType']['name'],
      gender: json['gender'],
      productCode: json['productCode'],
      brand: json['brand']['name'],
      images: (json['media']['images'] as List<dynamic>)
          .map((e) => e['url'].toString())
          .toList(),
      currentPrice: json['price']['current']['value'],
      previousPrice: json['price']['previous']['value'],
      currency: json['price']['currency'],
      startDateTime: json['startDateTime'],
    );
  }
}
