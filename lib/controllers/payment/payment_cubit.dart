import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/view/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/domain/entities/payment/payment_entity.dart';
import 'package:fashion_app/domain/usecases/payment/create_payment_intent_usecase.dart';

import '../checkout/checkout_cubit.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._intentUsecase) : super(PaymentInitial());
  Map<String, dynamic>? paymentIntentData;
  PaymentEntity? paymentEntity;

  final CreatePaymentIntentUsecase _intentUsecase;
  Future<void> makePayment(
    BuildContext context,
  ) async {
    try {
      await createPaymentIntent(totalPrice(context), "USD");
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
          ),
        );
        // ignore: use_build_context_synchronously
        await displayPaymentSheet(context);
      }
    } catch (e, s) {
      log('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // ignore: use_build_context_synchronously
      context.goTo(const PaymentScreen(), true);
    } on Exception catch (e) {
      if (e is StripeException) {
        log("Error from Stripe: ${e.error.localizedMessage}");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createPaymentIntent(String amount, String currency) async {
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

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  String totalPrice(BuildContext context) {
    return BlocProvider.of<CheckoutCubit>(context)
        .getPriceTotal(context)
        .toStringAsFixed(0);
  }
}
