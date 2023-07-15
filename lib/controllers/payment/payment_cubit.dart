import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/domain/entities/account/user.dart';

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
  PaymentEntity? paymentEntity;
  BillingDetails? _billingDetails;
  final CreatePaymentIntentUsecase _intentUsecase;

  Future<void> makePayment(
    BuildContext context,
  ) async {
    try {
      await _createPaymentIntent(totalPrice(context), "USD");
      if (paymentEntity != null) {
        // ignore: use_build_context_synchronously
        _billingDetails = getBillingDetails(context);
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: true,
            //applePay: const PaymentSheetApplePay(merchantCountryCode: "US"),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
            allowsDelayedPaymentMethods: true,
            merchantDisplayName: 'Prospects',
            customerId: paymentEntity!.customer,
            paymentIntentClientSecret: paymentEntity!.clientSecret,
            customerEphemeralKeySecret: paymentEntity!.ephemeralKey,
            billingDetails: _billingDetails,
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
      // to display payment sheet
      await Stripe.instance.presentPaymentSheet();
      // ignore: use_build_context_synchronously
      goToPaymentSuccessfully(context);
    } on Exception catch (e) {
      if (e is StripeException) {
        log("Error from Stripe: ${e.error.localizedMessage}");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _createPaymentIntent(String amount, String currency) async {
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

  BillingDetails getBillingDetails(BuildContext context) {
    final selectAddress = BlocProvider.of<CheckoutCubit>(context)
        .getSelectedAddress(context)
        .addressLocation;
    final address = Address(
        city: selectAddress?.city,
        country: selectAddress?.country,
        line1: selectAddress?.street,
        line2: '',
        postalCode: "",
        state: selectAddress?.state);
    print(address.city);
    print(address.country);

    final user = _getUser(context);
    print(user?.email);
    print(user?.username);
    return BillingDetails(
        address: address,
        email: user?.email,
        name: user?.username,
        phone: user?.phoneNumber);
  }

  UserModel? _getUser(BuildContext context) {
    return BlocProvider.of<UserCubit>(context).getUser;
  }

  goToPaymentSuccessfully(BuildContext context) {
    final screen = BlocProvider.value(
      value: BlocProvider.of<PaymentCubit>(context),
      child: const PaymentScreen(),
    );
    context.goTo(screen, true);
  }

  getYourReceipt(BuildContext context) {
    //TODO
  }

  backToHome(BuildContext context) {
    BlocProvider.of<CartCubit>(context).clearAllProductsInCart();
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.home,
      (route) => false,
    );
  }
}
