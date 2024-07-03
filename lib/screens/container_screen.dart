import 'package:buy_car_rule/providers/calculator_form_provider.dart';
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
    final calculatorFormNotifier = ref.read(calculatorFormProvider.notifier);

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

    return Scaffold(
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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          screenOptions[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      body: Center(
        child: screenOptions[_selectedPageIndex]['widget'],
      ),
    );
  }
}
