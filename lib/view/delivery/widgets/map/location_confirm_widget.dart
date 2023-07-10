import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/map/map_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class LocationConfirmWidget extends StatelessWidget {
  const LocationConfirmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MapCubit>(context);
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextUtils(
                text:
                    '${cubit.addressLocation.country}, ${cubit.addressLocation.state}',
                color: AppColor.black,
              ),
              TextUtils(
                  text:
                      '${cubit.addressLocation.city}, ${cubit.addressLocation.street}',
                  color: AppColor.black50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: CustomElevatedButton(
                  label: 'Confirm',
                  press: () {
                    _confirm(context, cubit);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirm(BuildContext context, MapCubit cubit) async {
    BlocProvider.of<AddressCubit>(context)
        .updateAddressLocation(cubit.addressLocation);
    context.back();
  }
}
