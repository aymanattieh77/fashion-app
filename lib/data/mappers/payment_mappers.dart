import 'package:fashion_app/data/models/payment/payment_response.dart';
import 'package:fashion_app/domain/entities/payment/payment_entity.dart';

extension PaymentResponseEx on PaymentResponse {
  toDomain() {
    return PaymentEntity(
        id: id ?? "",
        object: object ?? "",
        amount: amount ?? 0,
        created: created ?? 0,
        currency: currency ?? "USD",
        status: status ?? "",
        clientSecret: clientSecret ?? "",
        customer: customer ?? "",
        ephemeralKey: ephemeralKey ?? "");
  }
}
