import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  LocalStorage._();

  static SharedPreferences? get shared => _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    return _prefs?.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    await _prefs?.setString(key, value);
  }

  static Future<void> remove(String key) async {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    await _prefs?.remove(key);
  }

  static void reset() {
    _prefs = null;
  }
}
