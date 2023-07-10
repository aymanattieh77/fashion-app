import 'package:fashion_app/config/language/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const isDarkTheme = 'IS_DARK';
const completeBoarding = 'COMPLETE_ON_ONBOARDING';
const isLogged = 'IS_LOGGED';
const recentSearchesKey = 'RECENT_SEARCH';
const keyLanguage = 'KEY_LANGUAGE';
const localKey = 'LOCAL_KEY';

abstract class AppPrefs {
  Future<void> saveThemeMode(bool isDark);
  bool isDark();

  Future<void> completeOnBoarding();
  bool isCompleteOnBoarding();

  Future<void> saveUserUid(String uid);
  Future<void> deleteUserUid();

  bool isUserLoginIn();
  String get userUid;

  void saveRecentSearches(String searchValue);
  List<String> getRecentSearches();
  void clearRecentSearches();

  Future<String> getAppLanguage();
  Future<void> changeAppLanguage(LanguageType languageType);
  Future<Locale> getLocale();
}

class AppPrefsImpl implements AppPrefs {
  final SharedPreferences _prefs;

  AppPrefsImpl(this._prefs);

  @override
  saveThemeMode(bool isDark) async {
    await _prefs.setBool(isDarkTheme, isDark);
  }

  @override
  bool isDark() {
    return _prefs.getBool(isDarkTheme) ?? false;
  }

  @override
  Future<void> completeOnBoarding() async {
    await _prefs.setBool(completeBoarding, true);
  }

  @override
  bool isCompleteOnBoarding() {
    return _prefs.getBool(completeBoarding) ?? false;
  }

  @override
  Future<void> saveUserUid(String uid) async {
    await _prefs.setString(isLogged, uid);
  }

  @override
  bool isUserLoginIn() {
    String? uid = _prefs.getString(isLogged);
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String get userUid => _prefs.getString(isLogged) ?? "";

  @override
  saveRecentSearches(String searchValue) {
    if (searchValue.isNotEmpty) {
      _saveSearches(searchValue);
    } else {
      return;
    }
  }

  _saveSearches(String searchValue) {
    if (_prefs.containsKey(recentSearchesKey) &&
        getRecentSearches().isNotEmpty) {
      var searches = getRecentSearches();
      if (searches.contains(searchValue)) {
        return;
      } else {
        searches.add(searchValue);
      }
      _prefs.setStringList(recentSearchesKey, searches);
    } else {
      _prefs.setStringList(recentSearchesKey, [searchValue]);
    }
  }

  @override
  List<String> getRecentSearches() {
    return _prefs.getStringList(recentSearchesKey) ?? [];
  }

  @override
  void clearRecentSearches() {
    _prefs.remove(recentSearchesKey);
  }

  @override
  Future<String> getAppLanguage() async {
    String? language = _prefs.getString(keyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  @override
  Future<void> changeAppLanguage(LanguageType languageType) async {
    if (languageType.getValue() == LanguageType.english.getValue()) {
      _prefs.setString(keyLanguage, LanguageType.english.getValue());
    } else {
      _prefs.setString(keyLanguage, LanguageType.arabic.getValue());
    }
  }

  @override
  Future<Locale> getLocale() async {
    String currnetLang = await getAppLanguage();
    if (currnetLang == LanguageType.english.getValue()) {
      return englishLocale;
    } else {
      return arabicLocale;
    }
  }

  @override
  Future<void> deleteUserUid() async {
    await _prefs.remove(isLogged);
  }
}
