import 'package:buy_car_rule/screens/calculator_screen.dart';
import 'package:buy_car_rule/widgets/main_drawer.dart';
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

  static const List<Map<String, dynamic>> _screenOptions = [
    {'widget': CalculatorScreen(), 'title': 'Calculator'},
    {
      'widget': Text(
        'Home 1',
        style: TextStyle(color: Colors.white),
      ),
      'title': 'Home 1'
    }
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
