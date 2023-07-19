import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_app/core/utils/utils.dart';

import 'package:fashion_app/config/services/permissions.dart';
import 'package:fashion_app/config/services/prefs.dart';

import 'package:fashion_app/data/network/dio_factory.dart';

import 'package:fashion_app/core/network_info/network_info.dart';

import 'package:fashion_app/data/data_source/data_sources.dart';

import 'package:fashion_app/data/local/location/location_service.dart';
import 'package:fashion_app/data/local/location/location_service_impl.dart';

import 'package:fashion_app/data/remote/remote.dart';
import 'package:fashion_app/data/repository/repositories.dart';

import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/usecases.dart';

import 'package:fashion_app/controllers/controllers.dart';

final getIt = GetIt.instance;

serviceLocatorStart() async {
  await setupAppService();
  setupThemeService();
  setupLocalDataService();
  setupAPIService();
  setupRemoteDataSource();
  setupAppRepositories();
  setupUserService();
  setupFavouritesService();
}

setupAppService() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(prefs));
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
  getIt.registerLazySingleton<AppPermissions>(() => AppPermissionsImpl());
}

setupThemeService() {
  final isDark = getIt<AppPrefs>().isDark();
  if (GetIt.I.isRegistered<ThemeCubit>()) {
    getIt.unregister<ThemeCubit>();
  }
  getIt.registerFactory<ThemeCubit>(
      () => ThemeCubit(isDark ? ThemeMode.dark : ThemeMode.light));
}

setupLocalDataService() {
  getIt.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  getIt.registerLazySingleton<LocationLocalDataSource>(
      () => LocationLocalDataSourceImpl(getIt()));
}

setupAPIService() {
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  getIt.registerLazySingleton<DioFactroy>(() => DioFactroyImpl());

  final productServiceHeaders = <String, String>{
    "X-RapidAPI-Key": dotenv.env[AppConstants.apiKey] as String,
    "X-RapidAPI-Host": dotenv.env[AppConstants.apiHost] as String
  };
  final productServiceDio = getIt<DioFactroy>().getDio(productServiceHeaders);
  getIt.registerLazySingleton<ProductService>(
      () => ProductService(productServiceDio));

  getIt.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  getIt.registerLazySingleton<FirebaseUserService>(
      () => FirebaseUserServiceImpl());
  getIt.registerLazySingleton<FirebaseAddressService>(
      () => FirebaseAddressServiceImpl());
  getIt.registerLazySingleton<FirebaseFavouriteService>(
      () => FirebaseFavouriteServiceImpl());
  final paymentServiceHeaders = <String, String>{
    'Authorization': 'Bearer ${dotenv.env[AppConstants.stripeKey]}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  final paymentServiceDio = getIt<DioFactroy>().getDio(paymentServiceHeaders);
  getIt.registerLazySingleton<PaymentService>(
      () => PaymentService(paymentServiceDio));

  getIt.registerLazySingleton<StorageService>(() => StorageServiceImpl());
}

setupRemoteDataSource() {
  getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<FavouriteRemoteDataSource>(
      () => FavouriteRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<PaymentRemoteDateSource>(
      () => PaymentRemoteDateSourceImpl(getIt()));
}

setupAppRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthService>()));
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<CategoryProductRepository>(
      () => CategoryProductRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<SearchProductRepository>(
      () => SearchProductRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<FirebaseUserRepository>(
      () => FirebaseUserRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FirebaseAddressRepository>(
      () => FirebaseAddressRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FirebaseFavouriteRepository>(
      () => FirebaseFavouritesRepositoryImpl(getIt()));
  getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(getIt()));
}

setupUserService() {
  if (!GetIt.I.isRegistered<UserCubit>()) {
    getIt.registerLazySingleton<GetUserProfileByIdUseCase>(
        () => GetUserProfileByIdUseCase(getIt()));
    getIt.registerLazySingleton<DeleteUserProfileUsecase>(
        () => DeleteUserProfileUsecase(getIt()));
    getIt.registerLazySingleton<UpdateUserProfileUsecase>(
        () => UpdateUserProfileUsecase(getIt()));
    getIt.registerLazySingleton<SaveUserProfileUsecase>(
        () => SaveUserProfileUsecase(getIt()));

    getIt.registerFactory<UserCubit>(
        () => UserCubit(getIt(), getIt(), getIt(), getIt()));
  }
}

setupAddressService() {}

setupPaymentService() {
  if (!GetIt.I.isRegistered<CreatePaymentIntentUsecase>()) {
    getIt.registerLazySingleton<CreatePaymentIntentUsecase>(
        () => CreatePaymentIntentUsecase(getIt()));
    getIt.registerFactory<PaymentCubit>(() => PaymentCubit(getIt()));
  }
}

setupFavouritesService() {
  if (!GetIt.I.isRegistered<FavouriteCubit>()) {
    // favourites usecases
    getIt.registerLazySingleton<AddFavouriteProductUsecase>(
        () => AddFavouriteProductUsecase(getIt()));
    getIt.registerLazySingleton<DeleteFavouriteProductUsecase>(
        () => DeleteFavouriteProductUsecase(getIt()));
    getIt.registerLazySingleton<ClearFavouritesProductsUsecase>(
        () => ClearFavouritesProductsUsecase(getIt()));
    getIt.registerLazySingleton<GetFavouritesProductsUsecase>(
        () => GetFavouritesProductsUsecase(getIt()));
    // cubit
    getIt.registerFactory<FavouriteCubit>(
        () => FavouriteCubit(getIt(), getIt(), getIt(), getIt()));
  }
}

setupAuthUsecase() {
  getIt.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignINWithGoogleUsecase>(
      () => SignINWithGoogleUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignInWithFacebook>(
      () => SignInWithFacebook(getIt<AuthRepository>()));
  getIt.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignoutUsecase>(
      () => SignoutUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<UpdateEmailUsecase>(
      () => UpdateEmailUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<ReAuthenticatesUserUsecase>(
      () => ReAuthenticatesUserUsecase(getIt<AuthRepository>()));

  getIt.registerLazySingleton<AuthUsecases>(() => AuthUsecases(
        loginUsecase: getIt(),
        withFacebookUsecase: getIt(),
        withGoogleUsecase: getIt(),
        signoutUsecase: getIt(),
        signUpUsecase: getIt(),
        resetPasswordUsecase: getIt(),
        updateEmailUsecase: getIt(),
      ));
}

setupProductDetail() {
  if (!GetIt.I.isRegistered<ProductDetailCubit>()) {
    getIt.registerLazySingleton<GetProdcutDetailById>(
        () => GetProdcutDetailById(getIt()));
    getIt
        .registerFactory<ProductDetailCubit>(() => ProductDetailCubit(getIt()));
  }
}

setupCheckoutService() {
  if (!GetIt.I.isRegistered<CheckoutCubit>()) {
    getIt.registerFactory<CheckoutCubit>(() => CheckoutCubit());
  }
}

setupSearchProducts() {
  if (!GetIt.I.isRegistered<SearchCubit>()) {
    getIt.registerLazySingleton<GetProductsBySearchUsecase>(
        () => GetProductsBySearchUsecase(getIt()));
    getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  }
}

setupCategoryProduct() {
  if (!GetIt.I.isRegistered<CategoryProductCubit>()) {
    getIt.registerLazySingleton<GetProductsByFilterUsecase>(
        () => GetProductsByFilterUsecase(getIt()));
    getIt.registerFactory<CategoryProductCubit>(
        () => CategoryProductCubit(getIt()));
  }
}

void setupHomeService() {
  if (!GetIt.I.isRegistered<MainCubit>()) {
    getIt.registerLazySingleton<GetHomeProductsUsecase>(
        () => GetHomeProductsUsecase(getIt()));
    getIt.registerFactory<MainCubit>(() => MainCubit());
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  }
}

setupMapService() {
  if (!GetIt.I.isRegistered<AddressCubit>()) {
    getIt.registerFactory<AddressCubit>(() => AddressCubit(getIt()));
    getIt.registerFactory<MapCubit>(() => MapCubit(getIt()));
  }
}

void setupAuthService() {
  if (!GetIt.I.isRegistered<AuthCubit>()) {
    setupAuthUsecase();
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthUsecases>()));
  }
}

void setupProfileService() {
  if (!GetIt.I.isRegistered<ProfileCubit>()) {
    getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
          getIt<StorageService>(),
          getIt<UpdateEmailUsecase>(),
          getIt<ReAuthenticatesUserUsecase>(),
        ));
  }
}
