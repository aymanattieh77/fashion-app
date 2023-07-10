class ProductModel {
  final int? id;
  final String? name;
  final double? price;
  final String? currency;
  final String? brandName;
  final String? colour;
  final int? productCode;
  final String? url;
  final String? imageUrl;
  final List<String>? additionalImageUrls;
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.currency,
    this.brandName,
    this.colour,
    this.productCode,
    this.url,
    this.imageUrl,
    this.additionalImageUrls,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price']['current']['value'],
      currency: json['currency'],
      brandName: json['brandName'],
      colour: json['colour'],
      productCode: json['productCode'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      additionalImageUrls: (json['additionalImageUrls'] as List)
          .map((e) => e.toString())
          .toList(),
    );
  }
}
