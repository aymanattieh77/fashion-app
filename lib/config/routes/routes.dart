import 'package:fashion_app/view/about/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fashion_app/config/routes/route_context.dart';

import 'package:fashion_app/config/services/service_locator.dart';

import 'package:fashion_app/controllers/controllers.dart';

import 'package:fashion_app/view/views.dart';

abstract class Routes {
  static const splash = '/';
  static const onBoarding = '/OnBoarding';
  static const auth = '/auth';
  static const home = '/home';
  static const settings = '/settings';
  static const account = '/account';
  static const search = '/search';
  static const cart = '/cart';
  static const favourite = '/favourite';
  static const notification = '/notification';
  static const delivery = '/delivery';
  static const checkout = '/checkout';
  static const paymentSuccessfull = '/payment_success_full';
  static const privacyPolicy = '/privacy_policy';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return screen(_splash());
      case Routes.onBoarding:
        return screen(_onBoarding());
      case Routes.auth:
        return screen(_auth());
      case Routes.home:
        return screen(_home());
      case Routes.settings:
        return screen(_settings());
      case Routes.account:
        return screen(_account());
      case Routes.search:
        return screen(_search(), PageTransitionType.fade);
      case Routes.cart:
        return screen(_cart(), PageTransitionType.topToBottom);
      case Routes.favourite:
        return screen(_favourite());

      case Routes.notification:
        return screen(_notification(), PageTransitionType.topToBottom);
      case Routes.delivery:
        return screen(_deliveryAddress());
      case Routes.checkout:
        return screen(_checkout());
      case Routes.paymentSuccessfull:
        return screen(_paymentSuccessfully(), PageTransitionType.fade);
      case Routes.privacyPolicy:
        return screen(_privacyPolicy());
      default:
        return unKnowunScreen();
    }
  }

  static _splash() {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    );
  }

  static _onBoarding() {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: const OnBoardingScreen(),
    );
  }

  static _auth() {
    setupAuthService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
      ],
      child: const AuthScreen(),
    );
  }

  static _home() {
    setupAuthService();
    setupHomeService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<MainCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
      ],
      child: const HomeScreen(),
    );
  }

  static _settings() {
    return const SettingScreen();
  }

  static _account() {
    setupProfileService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
      ],
      child: const ProfileSettings(),
    );
  }

  static _notification() {
    return const NotiFicationScreen();
  }

  static _cart() {
    return const CartScreen();
  }

  static _favourite() {
    return const FavouriteScreen();
  }

  static _paymentSuccessfully() {
    return const PaymentSuccessfullyScreen();
  }

  static _checkout() {
    setupMapService();
    setupCheckoutService();
    setupPaymentService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddressCubit>()),
        BlocProvider(create: (context) => getIt<CheckoutCubit>()),
        BlocProvider(create: (context) => getIt<PaymentCubit>()),
      ],
      child: const CheckoutScreen(),
    );
  }

  static _deliveryAddress() {
    setupMapService();
    return BlocProvider(
      create: (context) => getIt<AddressCubit>()..getSavedAddress(),
      child: const DeliveryAddress(),
    );
  }

  static _search() {
    setupHomeService();
    setupSearchProducts();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => getIt<SearchCubit>()),
      ],
      child: const SearchPage(),
    );
  }

  static _privacyPolicy() {
    return const PrivacyPolicyScreen();
  }
}
