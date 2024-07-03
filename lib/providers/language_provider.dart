import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<Map<String, String>> {
  LanguageNotifier() : super(_initializeLanguage());

  static Map<String, String> _initializeLanguage() {
    final languageCode = PlatformDispatcher.instance.locale.languageCode;
    // Validar si el idioma es 'en' o 'es', de lo contrario establecer 'en' por defecto
    if (languageCode != 'en' && languageCode != 'es') {
      return {'language': 'en'};
    }
    return {'language': languageCode};
  }

  void setLanguage(String value) {
    state = {...state, 'language': value};
  }
}

final languageProvider =
    StateNotifierProvider<LanguageNotifier, Map<String, String>>((ref) {
  return LanguageNotifier();
});
