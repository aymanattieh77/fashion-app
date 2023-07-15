import 'package:fashion_app/controllers/checkout/checkout_cubit.dart';
import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/controllers/payment/payment_cubit.dart';
import 'package:fashion_app/data/data_source/favourites_remote_data_source.dart';
import 'package:fashion_app/data/data_source/payment_remote_data_source.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_favourite_service.dart';
import 'package:fashion_app/data/remote/payment/payment_service.dart';
import 'package:fashion_app/data/repository/firebase_address_repository_impl.dart';
import 'package:fashion_app/data/repository/firebase_favourites_repository_impl.dart';
import 'package:fashion_app/data/repository/payment_repository_impl.dart';
import 'package:fashion_app/domain/usecases/favourites/add_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/clear_favourites_products_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/delete_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/get_favourites_products_usecase.dart';
import 'package:fashion_app/domain/usecases/payment/create_payment_intent_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_app/config/services/permissions.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:fashion_app/controllers/app/app_cubit.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/controllers/home/home_cubit.dart';
import 'package:fashion_app/controllers/main/main_cubit.dart';
import 'package:fashion_app/controllers/map/map_cubit.dart';
import 'package:fashion_app/controllers/product_detail/product_detail_cubit.dart';
import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/controllers/theme/theme_cubit.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/network_info/network_info.dart';
import 'package:fashion_app/data/data_source/address_remote_data_source.dart';
import 'package:fashion_app/data/data_source/local_data_source.dart';
import 'package:fashion_app/data/data_source/product_remote_data_source.dart';
import 'package:fashion_app/data/data_source/user_remote_data_source.dart';
import 'package:fashion_app/data/local/location/location_service.dart';
import 'package:fashion_app/data/local/location/location_service_impl.dart';
import 'package:fashion_app/data/network/dio_factory.dart';
import 'package:fashion_app/data/remote/auth/auth_service.dart';
import 'package:fashion_app/data/remote/auth/auth_service_impl.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_address_service.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_user_service.dart';
import 'package:fashion_app/data/remote/product/product_service.dart';
import 'package:fashion_app/data/repository/auth_repository_impl.dart';
import 'package:fashion_app/data/repository/category_product_repository.dart';
import 'package:fashion_app/data/repository/firebase_user_repository_impl.dart';
import 'package:fashion_app/data/repository/home_product_repository.dart';
import 'package:fashion_app/data/repository/product_detail_repository.dart';
import 'package:fashion_app/data/repository/search_product_repository.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/auth/auth_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/login_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/reset_password_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_out_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_with_facebook_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_with_google_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/updata_email_usecase.dart';
import 'package:fashion_app/domain/usecases/category/get_products_by_filter_usecase.dart';
import 'package:fashion_app/domain/usecases/detail/get_product_detail_by_id.dart';
import 'package:fashion_app/domain/usecases/home/get_home_products_usecase.dart';
import 'package:fashion_app/domain/usecases/search/get_product_by_search_usecase.dart';
import 'package:fashion_app/domain/usecases/user/delete_user_profile_usecase.dart';
import 'package:fashion_app/domain/usecases/user/get_user_profile_by_id_usecase.dart';
import 'package:fashion_app/domain/usecases/user/save_user_profile_usecase.dart';
import 'package:fashion_app/domain/usecases/user/update_user_profile_usecase.dart';

final getIt = GetIt.instance;

serviceLocatorStart() async {
  await setupAppService();
  await setupThemeService();
  await setupLocalDataService();
  await setupAPIService();
  await setupRemoteDataSource();
  await setupAppRepositories();
  await setupUserService();
}

setupAPIService() {
  getIt.registerLazySingleton<DioFactroy>(() => DioFactroy());
  final dio = getIt<DioFactroy>().dio;
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  getIt.registerLazySingleton<ProductService>(() => ProductService(dio));
  getIt.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  getIt.registerLazySingleton<FirebaseUserService>(
      () => FirebaseUserServiceImpl());
  getIt.registerLazySingleton<FirebaseAddressService>(
      () => FirebaseAddressServiceImpl());
  getIt.registerLazySingleton<FirebaseFavouriteService>(
      () => FirebaseFavouriteServiceImpl());

  getIt.registerLazySingleton<PaymentService>(() => PaymentService(dio));
  //TODO
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
      () => FirebaseFavouritesRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(getIt()));
}

setupLocalDataService() {
  getIt.registerLazySingleton<LocationService>(() => LocationServiceImpl());
  getIt.registerLazySingleton<LocationLocalDataSource>(
      () => LocationLocalDataSourceImpl(getIt()));
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
