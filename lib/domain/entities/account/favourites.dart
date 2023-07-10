class Favourites {
  final List<int> productsId;
  Favourites({
    required this.productsId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productsId,
    };
  }

  factory Favourites.fromMap(Map<String, dynamic> map) {
    return Favourites(
      productsId: List<int>.from(
        (map['productId'] as List<dynamic>),
      ),
    );
  }
}

class ProductsFavourite {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  ProductsFavourite({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductsFavourite.fromJson(Map<String, dynamic> json) {
    return ProductsFavourite(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
