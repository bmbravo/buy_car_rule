import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Calculadora',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}
