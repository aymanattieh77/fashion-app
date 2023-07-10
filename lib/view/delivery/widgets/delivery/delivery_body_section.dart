import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/delivery/pages/edit_address_page.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';
import 'package:fashion_app/view/widgets/state_renderer/empty_state.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryBodySection extends StatelessWidget {
  const DeliveryBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (BlocProvider.of<AddressCubit>(context).addressList.isEmpty) {
          return const EmptyState(
              icon: Icons.location_city, message: AppStrings.notFoundAddress);
        } else {
          if (state is AddressLoading) {
            return loadingCircularWidget();
          } else {
            final address = BlocProvider.of<AddressCubit>(context).addressList;
            return ListView.separated(
              itemCount: address.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.goTo(
                      BlocProvider.value(
                        value: BlocProvider.of<AddressCubit>(context),
                        child: EditAddressPage(
                          address: address[index],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    showCustomDialog(
                      context,
                      CustomAlertDialog(
                        message: 'Are you sure delete address',
                        onCancel: () {},
                        onConfirm: () {
                          BlocProvider.of<AddressCubit>(context)
                              .deleteAddress(index);
                          context.back();
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextUtils(
                              text: address[index].addressType,
                              fontWe: FontWe.bold,
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit,
                              color: context.primaryColorLight,
                            )
                          ],
                        ),
                        TextUtils(
                          text:
                              '${address[index].streetName}, ${address[index].buildingNumber}, ${address[index].floor}',
                          fontSize: 14,
                          color: context.primaryColorLight,
                        ),
                        const SizedBox(height: 5),
                        TextUtils(
                          text: 'Mobile:  +962 ${address[index].phoneNumber}',
                          color: context.primaryColorLight,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1.2,
                    color: context.primaryColorLight,
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
