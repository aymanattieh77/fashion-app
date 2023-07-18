import 'package:dio/dio.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/data/models/payment/payment_response.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_service.g.dart';

@RestApi(baseUrl: AppConstants.stripeBaseUrl)
abstract class PaymentService {
  factory PaymentService(Dio dio, {String? baseUrl}) = _PaymentService;

  @POST("/payment_intents")
  Future<PaymentResponse> createPaymentIntent(
      @Body() Map<String, dynamic> body);

  @GET("/payment_intent/:{id}")
  Future<PaymentResponse> retrievePaymentIntent(@Path("id") String id);
}
