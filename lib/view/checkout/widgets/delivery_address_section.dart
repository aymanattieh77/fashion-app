import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/controllers/checkout/checkout_cubit.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextUtils(
            text: AppStrings.deliveryAddress,
            fontSize: 18,
            fontWe: FontWe.medium,
          ),
        ),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return loadingCircularWidget();
            }
            if (BlocProvider.of<AddressCubit>(context).addressList.isEmpty) {
              return const TextUtils(text: AppStrings.notFoundAddress);
            }
            return DeliveryAddressCard(
              address: BlocProvider.of<CheckoutCubit>(context)
                  .getSavedAddress(context),
            );
          },
        ),
      ],
    );
  }
}

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({
    super.key,
    required this.address,
  });

  final List<AddressEntity> address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHeight(0.25),
      child: ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Card(
              child: SizedBox(
                height: context.setHeight(0.12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<CheckoutCubit, CheckoutState>(
                      builder: (context, state) {
                        return Checkbox.adaptive(
                          value: BlocProvider.of<CheckoutCubit>(context)
                                  .addressCheck ==
                              index,
                          activeColor: AppColor.orange,
                          onChanged: (value) {
                            BlocProvider.of<CheckoutCubit>(context)
                                .setAddress(index);
                          },
                          shape: const CircleBorder(),
                          side: const BorderSide(
                              width: 1.0, color: AppColor.gray),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextUtils(
                            text: address[index].addressType,
                            fontSize: 15,
                            fontWe: FontWe.medium),
                        TextUtils(
                            text: address[index].phoneNumber,
                            fontSize: 12,
                            color: Theme.of(context).primaryColorLight),
                        TextUtils(
                            text:
                                '${address[index].streetName}, ${address[index].addressLocation!.city} ${address[index].addressLocation!.country}',
                            fontSize: 12,
                            color: Theme.of(context).primaryColorLight),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(AssetsIconPath.edit)),
                    const SizedBox(width: AppSizes.s5)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
