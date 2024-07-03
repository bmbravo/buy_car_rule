import 'package:buy_car_rule/providers/language_provider.dart';
import 'package:buy_car_rule/screens/container_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 68, 197, 229),
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 14, 12, 91),
  brightness: Brightness.dark,
);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.inconsolataTextTheme(),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: lightColorScheme.secondaryContainer,
    ),
    textStyle: TextStyle(
      fontSize: 16.0,
      color: lightColorScheme.onSurface,
    ),
  ),
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.inconsolataTextTheme(),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: darkColorScheme.onSurface,
    ),
    textStyle: TextStyle(
      fontSize: 16.0,
      color: lightColorScheme.onSurface,
    ),
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(
      const ProviderScope(
        child: App(),
      ),
    );
  });
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageProvider);

    return MaterialApp(
      locale: Locale(languageState['language']!),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      home: const LandingScreen(),
    );
  }
}
