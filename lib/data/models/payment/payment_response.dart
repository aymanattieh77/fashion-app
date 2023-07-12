class PaymentResponse {
  String? id;
  String? object;
  int? amount;
  int? created;
  String? currency;
  String? status;
  String? clientSecret;
  String? customer;
  String? ephemeralKey;
  PaymentResponse(
      {this.id,
      this.object,
      this.amount,
      this.created,
      this.currency,
      this.ephemeralKey,
      this.customer,
      this.status,
      this.clientSecret});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'amount': amount,
      'created': created,
      'currency': currency,
      'status': status,
    };
  }

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'] != null ? json['id'] as String : null,
      clientSecret: json['client_secret'] != null
          ? json['client_secret'] as String
          : null,
      object: json['object'] != null ? json['object'] as String : null,
      ephemeralKey:
          json['ephemeralKey'] != null ? json['ephemeralKey'] as String : null,
      customer: json['customer'] != null ? json['customer'] as String : null,
      amount: json['amount'] != null ? json['amount'] as int : null,
      created: json['created'] != null ? json['created'] as int : null,
      currency: json['currency'] != null ? json['currency'] as String : null,
      status: json['status'] != null ? json['status'] as String : null,
    );
  }
}
