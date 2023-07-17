import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/profile/profile_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/values.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        BlocProvider.of<ProfileCubit>(context)
            .pickImageFromCameraOrGallery(context);
      },
      child: SizedBox(
        width: AppSizes.s100 - 20,
        height: AppSizes.s100 - 20,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            _profilePicture(context),
            const Icon(Icons.camera_alt, color: AppColor.gray),
          ],
        ),
      ),
    );
  }

  Widget _profilePicture(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (_, state) {
        final image =
            BlocProvider.of<ProfileCubit>(context).profileImage(context);
        return CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(image),
        );
      },
    );
  }
}
