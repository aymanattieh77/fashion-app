import 'package:flutter/material.dart';

import 'package:fashion_app/view/delivery/widgets/delivery/custom_delivery_appbar.dart';
import 'package:fashion_app/view/delivery/widgets/delivery/delivery_body_section.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomDeliveryAppbar(),
      body: DeliveryBodySection(),
    );
  }
}
