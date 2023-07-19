import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/view/delivery/widgets/delivery/custom_delivery_appbar.dart';
import 'package:fashion_app/view/delivery/widgets/delivery/delivery_body_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomDeliveryAppbar(),
      body: DeliveryBodySection(),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<AddressCubit>(context).dispose();
    super.dispose();
  }
}
