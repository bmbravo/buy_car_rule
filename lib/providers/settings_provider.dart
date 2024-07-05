import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends StateNotifier<Map<String, dynamic>> {
  SettingsNotifier(super.initialSettings);

  void setLanguage(String value) async {
    state = {...state, 'language': value};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value);
  }

  void setDarkMode(bool isDarkMode) async {
    state = {...state, 'isDarkMode': isDarkMode};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Map<String, dynamic>>((ref) {
  final initialSettings = ref.watch(initialSettingsProvider).maybeWhen(
        data: (data) => data,
        orElse: () => {
          'language': 'en',
          'isDarkMode': false,
        },
      );
  return SettingsNotifier(initialSettings);
});

final initialSettingsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final storedLanguage = prefs.getString('language');
  final storedIsDarkMode = prefs.getBool('isDarkMode');
  // Obtener el tema actual del sistema utilizando MediaQuery
  final Brightness platformBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final isDarkMode = storedIsDarkMode ??
      (platformBrightness == Brightness.dark ? true : false);

  final languageCode = PlatformDispatcher.instance.locale.languageCode;
  final language = (storedLanguage != null &&
          (storedLanguage == 'en' || storedLanguage == 'es'))
      ? storedLanguage
      : (languageCode == 'en' || languageCode == 'es')
          ? languageCode
          : 'en';

  return {
    'language': language,
    'isDarkMode': isDarkMode,
  };
});
