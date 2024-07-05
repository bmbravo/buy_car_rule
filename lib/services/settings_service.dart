import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettings {
  static final SharedPreferencesSettings _instance =
      SharedPreferencesSettings._internal();

  factory SharedPreferencesSettings() {
    return _instance;
  }

  SharedPreferencesSettings._internal();

  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  Future<bool?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode');
  }
}
