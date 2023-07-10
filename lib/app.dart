import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/controllers/theme/theme_cubit.dart';
import 'package:fashion_app/core/utils/style.dart';

import 'config/services/service_locator.dart';

class FashionApp extends StatefulWidget {
  const FashionApp({super.key});

  @override
  State<FashionApp> createState() => _FashionAppState();
}

class _FashionAppState extends State<FashionApp> {
  @override
  void didChangeDependencies() {
    getIt<AppPrefs>().getLocale().then((locale) => context.setLocale(locale));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (_, state) {
        return MaterialApp(
          title: 'Fashion app',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state,
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
