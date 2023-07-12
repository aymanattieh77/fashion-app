class PaymentEntity {
  final String id;
  final String object;
  final int amount;
  final int created;
  final String currency;
  final String status;
  final String customer;
  final String ephemeralKey;
  final String clientSecret;
  PaymentEntity({
    required this.customer,
    required this.ephemeralKey,
    required this.clientSecret,
    required this.id,
    required this.object,
    required this.amount,
    required this.created,
    required this.currency,
    required this.status,
  });
}
