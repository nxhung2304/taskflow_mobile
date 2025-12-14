import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  LocalStorage._();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static String? getString(String key) => _prefs?.getString(key);

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}
