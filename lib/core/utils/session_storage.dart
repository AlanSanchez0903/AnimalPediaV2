import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  SessionStorage._();

  static const String _isLoggedInKey = 'is_logged_in';

  static Future<bool> hasActiveSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> saveSessionStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }
}
