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
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressFailure) {
          showFullScreenErrorState(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AddressLoading) {
          return loadingCircularWidget();
        } else if (BlocProvider.of<AddressCubit>(context).addressList.isEmpty) {
          return const EmptyState(
            icon: Icons.location_city,
            message: AppStrings.notFoundAddress,
          );
        } else if (state is AddressLoaded) {
          return AddressListview(
            address: AddressCubit.getCubit(context).addressList,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
