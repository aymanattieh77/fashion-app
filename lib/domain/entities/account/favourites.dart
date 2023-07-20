// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Favourites {
  final List<ProductsFavourite> favourites;
  Favourites({
    required this.favourites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favourites': favourites.map((x) => x.toMap()).toList(),
    };
  }

  factory Favourites.fromMap(Map<String, dynamic> map) {
    return Favourites(
      favourites: map['favourites'] != null
          ? List<ProductsFavourite>.from(
              (map['favourites'] as List<dynamic>).map<ProductsFavourite>(
                (x) => ProductsFavourite.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}

class ProductsFavourite extends Equatable {
  final int productId;
  final String name;
  final double price;
  final String imageUrl;
  const ProductsFavourite({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductsFavourite.fromMap(Map<String, dynamic> map) {
    return ProductsFavourite(
      productId: map['productId'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
    );
  }

  @override
  List<Object> get props => [productId, name, price, imageUrl];
}
