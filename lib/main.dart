import 'package:buy_car_rule/screens/container_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.inconsolataTextTheme(),
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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      home: const LandingScreen(),
    );
  }
}
