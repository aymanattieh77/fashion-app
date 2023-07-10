import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (BlocProvider.of<UserCubit>(context).getUser == null) {
          return loadingCircularWidget();
        }

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                    BlocProvider.of<UserCubit>(context).getUser!.profilePhoto),
              ),
              const SizedBox(height: AppSizes.s10),
              TextUtils(
                text: BlocProvider.of<UserCubit>(context).getUser!.username,
                fontWe: FontWe.medium,
                tr: false,
              ),
              const SizedBox(height: AppSizes.s10),
              TextUtils(
                text: BlocProvider.of<UserCubit>(context).getUser!.email,
                fontSize: 12,
                tr: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
