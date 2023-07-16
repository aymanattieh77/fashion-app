import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/profile/profile_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/auth/widgets/custom_input_field.dart';
import 'package:fashion_app/view/settings/widgets/profile_picture_widget.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ProfileCubit>(context);
    cubit.start(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.accountSettings),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Column(
                children: [
                  const ProfilePictureWidget(),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.username,
                    filedType: FieldType.text,
                    controller: cubit.username,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.email,
                    hint: AppStrings.email,
                    controller: cubit.email,
                    filedType: FieldType.text,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.phoneNumber,
                    controller: cubit.phone,
                    filedType: FieldType.text,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.zipcode,
                    controller: cubit.zipcode,
                    filedType: FieldType.text,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.location,
                    controller: cubit.location,
                    filedType: FieldType.text,
                  ),
                  CustomElevatedButton(
                    label: AppStrings.update,
                    press: () async {
                      await cubit.updateUserProfile(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
