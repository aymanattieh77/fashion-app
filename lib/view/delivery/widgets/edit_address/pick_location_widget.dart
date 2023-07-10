import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickLocationWidget extends StatelessWidget {
  const PickLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddressCubit.getCubit(context);
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Card(
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextUtils(
                      text:
                          '${cubit.addressLocation.country}, ${cubit.addressLocation.state}',
                      tr: false,
                    ),
                    const Spacer(),
                    SvgPicture.asset(AssetsIconPath.googleMap)
                  ],
                ),
                TextUtils(
                  text:
                      '${cubit.addressLocation.city}, ${cubit.addressLocation.street}',
                  color: context.primaryColorLight,
                  tr: false,
                ),
                const SizedBox(height: 15),
                CustomElevatedButton(
                  label: AppStrings.pickLocation,
                  press: () {
                    cubit.pickLocation(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
