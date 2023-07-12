import 'package:fashion_app/data/remote/payment/payment_service.dart';

import '../models/payment/payment_response.dart';

abstract class PaymentRemoteDateSource {
  Future<PaymentResponse> createPaymentIntent(
      {required String amount,
      required String currency,
      required String? paymentMethod});

  Future<PaymentResponse> retrievePaymentIntent(String id);
}

class PaymentRemoteDateSourceImpl implements PaymentRemoteDateSource {
  final PaymentService _service;
  PaymentRemoteDateSourceImpl(this._service);
  @override
  Future<PaymentResponse> createPaymentIntent(
      {required String amount,
      required String currency,
      required String? paymentMethod}) async {
    return await _service.createPaymentIntent({
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card'
    });
  }

  @override
  Future<PaymentResponse> retrievePaymentIntent(String id) async {
    return await _service.retrievePaymentIntent(id);
  }
}
