import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:fashion_app/domain/entities/account/orders.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

class AccountEntity {
  final UserModel user;
  final List<AddressEntity>? address;
  final List<Order>? orders;
  final List<int>? favourites;
  AccountEntity({
    this.favourites,
    required this.user,
    this.address,
    this.orders,
  });
}
