import 'dart:io';

import 'package:fashion_app/controllers/profile/profile_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/auth/widgets/custom_input_field.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late UserCubit cubit;
  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final location = TextEditingController();
  final zipcode = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<UserCubit>(context);

    if (cubit.user != null) {
      username.text = cubit.user!.username;
      email.text = cubit.user!.email;
      phone.text = cubit.user!.phoneNumber ?? "";
      location.text = cubit.user!.location ?? "";
      zipcode.text = cubit.user!.zipCode ?? "";
    }
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
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      //  Pick an image From Camera Or Gallery
                      BlocProvider.of<ProfileCubit>(context)
                          .updateProfilePicture(context);
                    },
                    child: SizedBox(
                      width: AppSizes.s100 - 20,
                      height: AppSizes.s100 - 20,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(cubit.user?.profilePhoto ?? ""),
                          ),
                          const Icon(Icons.camera_alt, color: AppColor.gray),
                        ],
                      ),
                    ),
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.username,
                    filedType: FieldType.text,
                    controller: username,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.email,
                    hint: AppStrings.email,
                    controller: email,
                    filedType: FieldType.text,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.phoneNumber,
                    controller: phone,
                    filedType: FieldType.text,
                  ),
                  const CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.zipcode,
                    filedType: FieldType.text,
                  ),
                  CustomInputField(
                    icon: AssetsIconPath.profile,
                    hint: AppStrings.location,
                    controller: location,
                    filedType: FieldType.text,
                  ),
                  CustomElevatedButton(
                    label: AppStrings.update,
                    press: () async {
                      await cubit.updateUserProfile(
                        context,
                        username: username.text,
                        email: email.text,
                        phone: phone.text,
                        location: location.text,
                        zipcode: zipcode.text,
                      );
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

  Future<String> _uploadAnImage(File file) async {
    final storage = FirebaseStorage.instance;
    Reference storageReference = storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch.toString()}');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    location.dispose();

    super.dispose();
  }
}
