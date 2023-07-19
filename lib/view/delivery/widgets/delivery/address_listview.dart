import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class AddressListview extends StatelessWidget {
  const AddressListview({super.key, required this.address});
  final List<AddressEntity> address;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: address.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            BlocProvider.of<AddressCubit>(context)
                .goToEditAddressPage(context, address[index]);
          },
          onLongPress: () {
            BlocProvider.of<AddressCubit>(context).delete(context, index);
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
                  tr: false,
                ),
                const SizedBox(height: 5),
                TextUtils(
                  text: 'Mobile:  +962 ${address[index].phoneNumber}',
                  color: context.primaryColorLight,
                  fontSize: 14,
                  tr: false,
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
