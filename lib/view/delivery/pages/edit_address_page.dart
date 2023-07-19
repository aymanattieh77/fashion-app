import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/delivery/widgets/edit_address/pick_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/address/address_cubit.dart';

import 'package:fashion_app/domain/entities/account/address.dart';

import 'package:fashion_app/view/delivery/widgets/edit_address/address_type_chip.dart';
import 'package:fashion_app/view/delivery/widgets/edit_address/custom_address_text_field.dart';

import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key, this.address});
  final AddressEntity? address;

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late final AddressCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<AddressCubit>(context)..start(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.editAddress),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: buildFormAddress(),
        ),
      ),
    );
  }

  Widget buildFormAddress() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Form(
          key: cubit.globalKey,
          child: Column(
            children: [
              const PickLocationWidget(),
              const SizedBox(height: 20),
              AddressTypeChip(
                currnetIndex: cubit.currentAddressType,
                onTap: cubit.onAddressTypeChange,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomAddressTextField(
                      hint: cubit.addressHint1,
                      controller: cubit.bNum,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (cubit.currentAddressType != 1)
                    Expanded(
                      child: CustomAddressTextField(
                        hint: AppStrings.floor,
                        controller: cubit.floor,
                        textInputType: TextInputType.number,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              CustomAddressTextField(
                hint: AppStrings.street,
                controller: cubit.street,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              CustomAddressTextField(
                hint: AppStrings.additionalDirectionsOptional,
                optional: true,
                controller: cubit.additional,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              CustomAddressTextField(
                hint: AppStrings.phoneNumber,
                controller: cubit.phone,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                label: AppStrings.save,
                press: _save,
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  _save() {
    cubit.save(context, widget.address);
  }
}
