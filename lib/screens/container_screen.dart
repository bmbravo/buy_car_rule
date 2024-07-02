import 'package:buy_car_rule/screens/calculator_screen.dart';
import 'package:buy_car_rule/screens/results_screen.dart';
import 'package:buy_car_rule/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() {
    return _LandingScreenState();
  }
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  int _selectedPageIndex = 0;

  List<Map<String, dynamic>> _screenOptions = [];

  @override
  void initState() {
    super.initState();
    _screenOptions = [
      {
        'widget': CalculatorScreen(onSelectScreen: _selectScreen),
        'title': 'Calculator'
      },
      {
        'widget': const Text(
          "Hola",
          style: TextStyle(color: Colors.red),
        ),
        'title': 'Home 1'
      },
      {
        'widget': ResultsScreen(
          onSelectScreen: _selectScreen,
        ),
        'title': 'Results'
      },
    ];
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              tooltip: 'Clear data',
              child: const Icon(
                CupertinoIcons.clear_circled,
                size: 35,
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          '${_screenOptions[_selectedPageIndex]['title']}',
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
        child: _screenOptions[_selectedPageIndex]['widget'],
      ),
    );
  }
}
