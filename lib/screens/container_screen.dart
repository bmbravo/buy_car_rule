import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:buy_car_rule/main.dart';
import 'package:buy_car_rule/providers/calculator_form_provider.dart';
import 'package:buy_car_rule/providers/settings_provider.dart';
import 'package:buy_car_rule/screens/calculator_screen.dart';
import 'package:buy_car_rule/screens/results_screen.dart';
import 'package:buy_car_rule/screens/settings_screen.dart';
import 'package:buy_car_rule/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() {
    return _LandingScreenState();
  }
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  int _selectedPageIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = darkTheme;
    final light = lightTheme;

    final calculatorFormNotifier = ref.read(calculatorFormProvider.notifier);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    // Configuración de screenOptions dentro del método build
    final List<Map<String, dynamic>> screenOptions = [
      {
        'widget': CalculatorScreen(onSelectScreen: _selectScreen),
        'title': AppLocalizations.of(context)!.calculatorScreenTitle,
      },
      {
        'widget': const SettingsScreen(),
        'title': AppLocalizations.of(context)!.settingsScreenTitle,
      },
      {
        'widget': ResultsScreen(onSelectScreen: _selectScreen),
        'title': AppLocalizations.of(context)!.resultsScreenTitle,
      },
    ];

    return ThemeSwitchingArea(
      child: Scaffold(
        floatingActionButton: _selectedPageIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  calculatorFormNotifier.reset();
                },
                tooltip: AppLocalizations.of(context)!.clearData,
                child: const Icon(
                  CupertinoIcons.clear_circled,
                  size: 35,
                ),
              )
            : null,
        appBar: AppBar(
          actions: [
            ThemeSwitcher(
              clipper: const ThemeSwitcherCircleClipper(),
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    if (mounted) {
                      // Verificar si el widget está montado
                      final brightness = ThemeModelInheritedNotifier.of(context)
                          .theme
                          .brightness;
                      settingsNotifier.setDarkMode(
                          brightness == Brightness.light ? true : false);
                      ThemeSwitcher.of(context).changeTheme(
                        theme: brightness == Brightness.light ? dark : light,
                        isReversed:
                            brightness == Brightness.light ? true : false,
                      );
                    }
                  },
                  icon: Icon(
                    ThemeModelInheritedNotifier.of(context).theme.brightness ==
                            Brightness.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                );
              },
            )
          ],
          title: Text(
            screenOptions[_selectedPageIndex]['title'],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 5),
          ),
        ),
        drawer: MainDrawer(
          onSelectScreen: _selectScreen,
        ),
        body: Center(
          child: screenOptions[_selectedPageIndex]['widget'],
        ),
      ),
    );
  }
}
