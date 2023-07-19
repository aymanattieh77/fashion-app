import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/controllers/main/main_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

import '../../../about/about_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s30),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (BlocProvider.of<UserCubit>(context).user == null) {
                return loadingCircularWidget();
              }
              return Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      BlocProvider.of<UserCubit>(context).user!.profilePhoto,
                    ),
                  ),
                  const SizedBox(width: AppSizes.s15),
                  Expanded(
                    child: TextUtils(
                      text: BlocProvider.of<UserCubit>(context)
                          .user!
                          .username
                          .toUpperCase(),
                      fontSize: 14,
                      fontWe: FontWe.medium,
                      maxlines: 1,
                      tr: false,
                      softWrap: false,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSizes.s30),
          IconWithTitle(
            icon: AssetsIconPath.heart,
            title: AppStrings.myFavorites,
            onTap: () {
              // Go to Favourites Screen
              context.goToNamed(route: Routes.favourite);
            },
          ),
          IconWithTitle(
            icon: AssetsIconPath.document,
            title: AppStrings.aboutUs,
            onTap: () {
              // Go to About Screen
              context.goTo(const AboutScreen());
            },
          ),
          IconWithTitle(
            icon: AssetsIconPath.lock,
            title: AppStrings.privacyPolicy,
            onTap: () {
              //TODO Go to Privacy Screen
            },
          ),
          IconWithTitle(
            icon: AssetsIconPath.setting,
            title: AppStrings.settings,
            onTap: () {
              // Go to Settings Screen

              context.goToNamed(route: Routes.settings);
            },
          ),
          const SizedBox(height: 30),
          IconWithTitle(
              icon: AssetsIconPath.logout,
              title: AppStrings.logout,
              onTap: () {
                // Show Dialog to confirm or cancel sign out or log out.
                BlocProvider.of<MainCubit>(context).signOut(context);
              }),
          const SizedBox(height: AppSizes.s30),
          SizedBox(
            width: 50,
            height: 60,
            child: SvgPicture.asset(AssetsIconPath.appIcon),
          ),
        ],
      ),
    );
  }
}

class IconWithTitle extends StatelessWidget {
  const IconWithTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final String icon;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 27,
              height: 24,
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(width: 16),
            TextUtils(text: title, fontSize: 14, fontWe: FontWe.medium)
          ],
        ),
      ),
    );
  }
}
