import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/view/delivery/widgets/delivery/custom_delivery_appbar.dart';
import 'package:fashion_app/view/delivery/widgets/delivery/delivery_body_section.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  late final AddressCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AddressCubit.getCubit(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomDeliveryAppbar(),
      body: DeliveryBodySection(),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
