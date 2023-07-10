import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/theme/theme_cubit.dart';

import 'package:fashion_app/config/routes/route_context.dart';

import 'package:fashion_app/config/services/prefs.dart';

import 'package:fashion_app/config/services/service_locator.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/settings/widgets/custom_list_tile.dart';

class SettingsBodySection extends StatelessWidget {
  const SettingsBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.s20),
            inkwellListTile(
              icon: AssetsIconPath.profile,
              title: AppStrings.accountSettings,
              onTap: () {
                // Go To Profile Settings Screen
                context.goToNamed(route: Routes.account);
              },
            ),
            inkwellListTile(
              icon: AssetsIconPath.profile,
              title: AppStrings.deliveryAddress,
              onTap: () {
                // go to delivery address screen
                context.goToNamed(route: Routes.delivery);
              },
            ),
            inkwellListTile(
              icon: AssetsIconPath.email,
              title: AppStrings.emailSupport,
              onTap: () {},
            ),
            inkwellListTile(
              icon: AssetsIconPath.infoSquare,
              title: AppStrings.changeLanguage,
              onTap: () {
                // Change App Language
                BlocProvider.of<AppCubit>(context).changeLanguage(context);
              },
            ),
            swaithListTile(
              title: AppStrings.notification,
              icon: AssetsIconPath.notifications,
              value: true,
              onChanged: (val) {
                //TODO Turn on Notitfications
              },
            ),
            swaithListTile(
              title: AppStrings.update,
              icon: AssetsIconPath.update,
              value: false,
              onChanged: (val) {
                // TODO Turn on Update
              },
            ),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                // Switch To Dark Theme or Vice versa
                return swaithListTile(
                  title: AppStrings.darkMode,
                  icon: AssetsIconPath.darkMode,
                  value: getIt<AppPrefs>().isDark(),
                  onChanged: BlocProvider.of<ThemeCubit>(context).changeTheme,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
