import 'package:fashion_app/view/delivery/widgets/delivery/address_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/state_renderer/empty_state.dart';

class DeliveryBodySection extends StatelessWidget {
  const DeliveryBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (BlocProvider.of<AddressCubit>(context).addressList.isEmpty) {
          return const EmptyState(
            icon: Icons.location_city,
            message: AppStrings.notFoundAddress,
          );
        } else {
          if (state is AddressLoading) {
            return loadingCircularWidget();
          } else {
            final address = BlocProvider.of<AddressCubit>(context).addressList;
            return AddressListview(address: address);
          }
        }
      },
    );
  }
}
