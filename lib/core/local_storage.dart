import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future<void> remove(String key);
  String? getString(String key);
  Future<void> setString(String key, String value);
}

class LocalStorage implements ILocalStorage {
  final SharedPreferences? _prefs;

  LocalStorage(this._prefs);

  SharedPreferences? get shared => _prefs;

  @override
  String? getString(String key) {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    return _prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    await _prefs.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    if (_prefs == null) throw Exception("LocalStorage not initialized");

    await _prefs.remove(key);
  }
}
