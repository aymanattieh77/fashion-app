import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/home/pages/catalog_page.dart';
import 'package:fashion_app/view/home/pages/home_page.dart';
import 'package:fashion_app/view/home/pages/profile_page.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  final advancedDrawerController = AdvancedDrawerController();
  int cutrentIndex = 0;

  final pageList = [
    const HomePage(),
    const CatalogPage(),
    const ProfilePage(),
  ];

  onPageChange(int index) {
    cutrentIndex = index;
    emit(MainNavigationBarChange());
  }

  hideDrawer() {
    advancedDrawerController.value = AdvancedDrawerValue.hidden();
  }

  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  dispose() {
    advancedDrawerController.dispose();
  }

  signOut(BuildContext context) {
    showCustomDialog(
      context,
      CustomAlertDialog(
        message: AppStrings.doYouWantToLogout,
        onCancel: () {
          context.back();
        },
        onConfirm: () async {
          await BlocProvider.of<AuthCubit>(context).signOut(context);
        },
        confirmText: AppStrings.logout,
        cancelText: AppStrings.cancel,
      ),
    );
  }
}
