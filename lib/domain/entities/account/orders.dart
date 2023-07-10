class Order {
  final int orderId;
  final int productId;
  final int productCode;
  final String image;
  final String name;
  final double price;
  final String date;

  Order({
    required this.orderId,
    required this.productId,
    required this.productCode,
    required this.image,
    required this.name,
    required this.price,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productCode': productCode,
      'image': image,
      'name': name,
      'price': price,
      'date': date,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] as int,
      productId: map['productId'] as int,
      productCode: map['productCode'] as int,
      image: map['image'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      date: map['date'] as String,
    );
  }
}
