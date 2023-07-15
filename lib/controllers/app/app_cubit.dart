import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:fashion_app/config/language/language_manager.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/controllers/filter/filter_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/categories/categories_screen.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';

import '../../view/product_details/product_details_screen.dart';
import '../product_detail/product_detail_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  _changeLanguage(BuildContext context, LanguageType languageType) async {
    final lang = await getIt<AppPrefs>().getAppLanguage();
    if (lang == languageType.getValue()) {
      // ignore: use_build_context_synchronously
      context.back();
      return;
    }
    await getIt<AppPrefs>().changeAppLanguage(languageType);
    // ignore: use_build_context_synchronously
    Phoenix.rebirth(context);
  }

  changeLanguage(BuildContext context) {
    showCustomDialog(
      context,
      CustomAlertDialog(
        message: AppStrings.changeLanguage,
        cancelText: 'Arabic',
        onCancel: () {
          _changeLanguage(context, LanguageType.arabic);
        },
        confirmText: 'English',
        onConfirm: () {
          _changeLanguage(context, LanguageType.english);
        },
      ),
    );
  }

  provideSettingsInputs(BuildContext context) {
    context.goToNamed(
      route: Routes.account,
      args: SettingsInputs(BlocProvider.of<AuthCubit>(context),
          BlocProvider.of<UserCubit>(context)),
    );
  }

  void goToProductDetailScreen(BuildContext context, int productId) {
    setupProductDetail();
    context.goTo(
      BlocProvider(
        create: (context) =>
            getIt<ProductDetailCubit>()..getProdcutDetailById(productId),
        child: ProductDetailsScreen(productId: productId),
      ),
    );
  }

  void goToProductCategoriesPage(
      BuildContext context, int categoryId, String categoryName) {
    setupCategoryProduct();
    context.goTo(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FilterCubit()),
          BlocProvider(create: (_) => getIt<CategoryProductCubit>()),
        ],
        child: CategoriesScreen(
          categoryId: categoryId,
          categoryName: categoryName,
        ),
      ),
    );
  }
}
