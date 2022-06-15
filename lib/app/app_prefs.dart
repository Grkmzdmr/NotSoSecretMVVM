import 'package:flutter/material.dart';
import 'package:not_so_secret/data/mapper/mapper.dart';
import 'package:not_so_secret/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_USERNAME = "PREFS_KEY_USERNAME";
const String PREFS_KEY_POST = "PREFS_KEY_POST";
const String PREFS_KEY_PAGE = "PREFS_KEY_PAGE";
const String PREFS_KEY_USERID = "PREFS_KEY_USERID";

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.English.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.Turkish.getValue()) {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.English.getValue());
    } else {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.Turkish.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.Turkish.getValue()) {
      return Turkish_LOCAL;
    } else {
      return English_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "No Token Saved";
  }

  Future<void> setPost(int id) async {
    _sharedPreferences.setInt(PREFS_KEY_POST, id);
  }

  Future<int> getPost() async {
    return _sharedPreferences.getInt(PREFS_KEY_POST) ?? 0;
  }

  Future<void> setPage(int page) async {
    _sharedPreferences.setInt(PREFS_KEY_PAGE, page);
  }

  Future<int> getPage() async {
    return _sharedPreferences.getInt(PREFS_KEY_PAGE) ?? 0;
  }

  Future<void> setUsername(String username) async {
    _sharedPreferences.setString(PREFS_KEY_USERNAME, username);
  }

  Future<String> getUsername() async {
    return _sharedPreferences.getString(PREFS_KEY_USERNAME) ??
        "No Username Saved";
  }
  Future<void> setUserId(int userId) async {
    _sharedPreferences.setInt(PREFS_KEY_USERID, userId);
  }

  Future<int> getUserId() async {
    return _sharedPreferences.getInt(PREFS_KEY_USERID) ??
        ZERO;
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
    _sharedPreferences.remove(PREFS_KEY_TOKEN);
    _sharedPreferences.remove(PREFS_KEY_USERNAME);
    _sharedPreferences.remove(PREFS_KEY_POST);
  }
}
