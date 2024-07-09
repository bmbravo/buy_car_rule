import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorInput extends StatelessWidget {
  const CalculatorInput({
    super.key,
    required this.textController,
    required this.onChanged,
    required this.labelText,
    this.inputFormatters,
    required this.icon,
    required this.keyboardType,
    this.maxLength,
    this.suffixIcon,
  });

  final String labelText;
  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final Widget icon;
  final TextInputType keyboardType;
  final int? maxLength;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: onChanged,
      maxLength: maxLength,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        counterText: '',
        icon: icon,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.only(
            top: 16.0), // Ajusta el valor según sea necesario
      ),
    );
  }
}
