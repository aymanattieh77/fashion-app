import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(super.initialState);

  final prefs = getIt<AppPrefs>();

  changeTheme(bool val) {
    if (prefs.isDark()) {
      prefs.saveThemeMode(false);
      emit(ThemeMode.light);
    } else {
      prefs.saveThemeMode(true);
      emit(ThemeMode.dark);
    }
  }
}
