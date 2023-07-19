import 'package:fashion_app/view/payment/widgets/payment_body_section.dart';
import 'package:flutter/material.dart';

class PaymentSuccessfullyScreen extends StatelessWidget {
  const PaymentSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: PaymentBodySection()),
    );
  }
}
