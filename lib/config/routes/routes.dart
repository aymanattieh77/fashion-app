import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/controllers/checkout/checkout_cubit.dart';
import 'package:fashion_app/controllers/filter/filter_cubit.dart';
import 'package:fashion_app/controllers/home/home_cubit.dart';
import 'package:fashion_app/controllers/main/main_cubit.dart';
import 'package:fashion_app/controllers/on_boarding/on_boarding_cubit.dart';
import 'package:fashion_app/controllers/payment/payment_cubit.dart';
import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/controllers/splash/splash_cubit.dart';
import 'package:fashion_app/view/Wallets/my_wallets_screen.dart';
import 'package:fashion_app/view/auth/auth_screen.dart';
import 'package:fashion_app/view/cart/cart_screen.dart';
import 'package:fashion_app/view/checkout/checkout_screen.dart';
import 'package:fashion_app/view/delivery/pages/delivery_address_screen.dart';
import 'package:fashion_app/view/favourite/favourite_screen.dart';
import 'package:fashion_app/view/home/home_screen.dart';
import 'package:fashion_app/view/notifications/notifications_screen.dart';
import 'package:fashion_app/view/on_boarding/on_boarding_screen.dart';
import 'package:fashion_app/view/orders/orders_screen.dart';
import 'package:fashion_app/view/search/search_page.dart';
import 'package:fashion_app/view/settings/profile_settings.dart';
import 'package:fashion_app/view/settings/settings_screen.dart';
import 'package:fashion_app/view/splash/splash_screen.dart';

abstract class Routes {
  static const splash = '/';
  static const onBoarding = '/OnBoarding';
  static const auth = '/auth';
  static const home = '/home';
  static const settings = '/settings';
  static const account = '/account';
  static const myWallets = '/my_wallets';
  static const search = '/search';
  static const cart = '/cart';
  static const favourite = '/favourite';
  static const orders = '/orders';
  static const notification = '/notification';
  static const delivery = '/delivery';
  static const checkout = '/checkout';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
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
      case Routes.myWallets:
        return screen(_wallats());
      case Routes.search:
        return screen(_search(), PageTransitionType.fade);
      case Routes.cart:
        return screen(_cart(), PageTransitionType.topToBottom);
      case Routes.favourite:
        return screen(_favourite());
      case Routes.orders:
        return screen(_orders());
      case Routes.notification:
        return screen(_notification());
      case Routes.delivery:
        return screen(_deliveryAddress());
      case Routes.checkout:
        return screen(_checkout());
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
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
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
    setupAuthService();
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
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

  static _orders() {
    return const OrdersScreen();
  }

  static _wallats() {
    return const MyWalletsScreen();
  }

  static _checkout() {
    setupMapService();
    setupCheckoutService();
    setupPaymentService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AddressCubit>()..getSavedAddress(),
        ),
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
}
