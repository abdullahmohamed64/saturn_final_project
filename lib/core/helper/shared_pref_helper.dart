import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences sharedPreferences;
  static late FlutterSecureStorage flutterSecureStorage;
  // private constructor as I don't want to allow creating an instance of this class itself.
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    flutterSecureStorage = FlutterSecureStorage();
  }

  /// Removes a value from SharedPreferences with given [key].
  removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  setData(String key, value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  bool getBool(String key) {
    debugPrint('SharedPrefHelper : getBool with key : $key');

    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  double getDouble(String key) {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  int getInt(String key) {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  String getString(String key) {
    debugPrint('SharedPrefHelper : getString with key : $key');
    return sharedPreferences.getString(key) ?? '';
  }

  void setSecuredData(String key, String value) {
    flutterSecureStorage.write(key: key, value: value);
  }

  Future<String> getSecuredData(String key) async {
    return await flutterSecureStorage.read(key: key) ?? "";
  }

  void clearAllSecuredData() {
    flutterSecureStorage.deleteAll();
  }
}
