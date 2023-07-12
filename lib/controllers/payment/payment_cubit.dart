import 'package:equatable/equatable.dart';
import 'package:fashion_app/domain/entities/payment/payment_entity.dart';
import 'package:fashion_app/domain/usecases/payment/create_payment_intent_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:fashion_app/core/functions/function.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._intentUsecase) : super(PaymentInitial());
  Map<String, dynamic>? paymentIntentData;
  PaymentEntity? paymentEntity;

  final CreatePaymentIntentUsecase _intentUsecase;
  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      await createPaymentIntent(amount, currency);
      if (paymentEntity != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          //applePay: const PaymentSheetApplePay(merchantCountryCode: "US"),
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          allowsDelayedPaymentMethods: true,
          merchantDisplayName: 'Prospects',
          customerId: paymentEntity!.customer,
          paymentIntentClientSecret: paymentEntity!.clientSecret,
          customerEphemeralKeySecret: paymentEntity!.ephemeralKey,
        ));
        await displayPaymentSheet();
      }
    } catch (e, s) {
      showToastMessage('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showToastMessage("Payment Successful");
      //context.goTo(const PaymentScreen());
    } on Exception catch (e) {
      if (e is StripeException) {
        showToastMessage("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        showToastMessage("Unforeseen error: $e");
      }
    } catch (e) {
      showToastMessage("exception:$e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    (await _intentUsecase.call(
      PaymentInputs(
        amount: calculateAmount(amount),
        currency: currency,
        paymentMethod: 'card',
      ),
    ))
        .fold(
      (failure) {
        emit(PaymentFailure());

        showToastMessage(failure.message);
      },
      (entity) {
        emit(PaymentSuccess());
        paymentEntity = entity;
      },
    );
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
