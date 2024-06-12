import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Keys for storing data
  static const String _isFirstTimeKey = 'isFirstTime';
  static const String _loginDataKey = 'loginData';
  static const String _signUpDataKey = 'signUpData';
  static const String _totalCoinsKey = 'totalCoins';
  static const String _lastEarnTimeKey = 'lastEarnTime';
  static const String _canEarnKey = 'canEarn';

  static bool isLoggedIn() {
    final loginData = _prefs.getString(_loginDataKey);
    return loginData != null;
  }

  // Getter and setter for first time login-
  static bool get isFirstTime => _prefs.getBool(_isFirstTimeKey) ?? true;

  static set isFirstTime(bool value) => _prefs.setBool(_isFirstTimeKey, value);

  // Methods to store and retrieve login data
  static Map<String, dynamic>? getLoginData() {
    final loginDataString = _prefs.getString(_loginDataKey);
    if (loginDataString != null) {
      return Map<String, dynamic>.from(json.decode(loginDataString));
    }
    return null;
  }

  static void setLoginData(Map<String, dynamic> data) {
    _prefs.setString(_loginDataKey, json.encode(data));
  }

  // Methods to store and retrieve sign up data
  static Map<String, dynamic>? getSignUpData() {
    final signUpDataString = _prefs.getString(_signUpDataKey);
    if (signUpDataString != null) {
      return Map<String, dynamic>.from(json.decode(signUpDataString));
    }
    return null;
  }

  static void setSignUpData(Map<String, dynamic> data) {
    _prefs.setString(_signUpDataKey, json.encode(data));
  }

  /// Store coin data
  static int get totalCoins => _prefs.getInt(_totalCoinsKey) ?? 0;

  static set totalCoins(int value) => _prefs.setInt(_totalCoinsKey, value);

  static DateTime? get lastEarnTime {
    final timestamp = _prefs.getInt(_lastEarnTimeKey);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  static set lastEarnTime(DateTime? value) {
    _prefs.setInt(_lastEarnTimeKey, value?.millisecondsSinceEpoch ?? 0);
  }

  static bool get canEarn => _prefs.getBool(_canEarnKey) ?? true;

  static set canEarn(bool value) => _prefs.setBool(_canEarnKey, value);

  // Method to clear all stored data (logout)
  static void clearUserData() {
    _prefs.remove(_loginDataKey);
    _prefs.remove(_totalCoinsKey);
    _prefs.remove(_lastEarnTimeKey);
    _prefs.remove(_canEarnKey);
  }
}
