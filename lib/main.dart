import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:fashion_app/app.dart';
import 'package:fashion_app/config/language/language_manager.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:fashion_app/controllers/bloc_observer/my_bloc_observer.dart';
import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';

import 'controllers/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await serviceLocatorStart();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      dotenv.env[AppConstants.stripePublishableKey] as String;
  await Stripe.instance.applySettings();

  Bloc.observer = MyBlocObserver();
  setupFavouritesService();
  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocale, arabicLocale],
      path: assetsPathLocalization,
      child: Phoenix(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<ThemeCubit>()),
            BlocProvider(create: (context) => getIt<AppCubit>()),
            BlocProvider(
                create: (context) => getIt<UserCubit>()
                  ..getUserProfileById(getIt<AppPrefs>().userUid ?? "")),
            BlocProvider(
                create: (context) =>
                    getIt<FavouriteCubit>()..getFavouritesProducts()),
            BlocProvider(create: (context) => CartCubit()),
          ],
          child: const FashionApp(),
        ),
      ),
    ),
  );
}
