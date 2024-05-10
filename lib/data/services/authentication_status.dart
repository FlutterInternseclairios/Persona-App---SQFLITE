import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationStatus {
  static const _isLoggedInKey = 'isLoggedIn';
  static const _emailKey = 'email';

  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> isLoggedIn() async {
    await _initPrefs();
    return _prefs!.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _initPrefs();
    await _prefs!.setBool(_isLoggedInKey, value);
  }

  Future<void> setEmail(String email) async {
    await _initPrefs();
    await _prefs!.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    await _initPrefs();
    return _prefs!.getString(_emailKey);
  }

  Future<void> clear() async {
    await _initPrefs();
    await _prefs!.remove(_isLoggedInKey);
    await _prefs!.remove(_emailKey);
  }
}
