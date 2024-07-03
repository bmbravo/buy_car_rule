import 'package:flutter/services.dart';

class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Permitir vaciar el campo de texto
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Permitir sólo números y punto decimal
    final newText = newValue.text;

    // Permitir sólo un punto decimal
    if ((newText.contains('.') &&
            newText.indexOf('.') != newText.lastIndexOf('.')) ||
        (newText.contains(',') &&
            newText.indexOf(',') != newText.lastIndexOf(','))) {
      return oldValue;
    }

    // Dividir el texto en parte entera y decimal
    List<String> parts;
    if (newText.contains('.')) {
      parts = newText.split('.');
    } else {
      parts = newText.split(',');
    }

    // Verificar que la parte entera esté entre 1 y 99
    final integerPart = parts[0];
    if (int.tryParse(integerPart) == null ||
        int.parse(integerPart) < 1 ||
        int.parse(integerPart) > 99) {
      return oldValue;
    }

    // Verificar que la parte decimal no tenga más de dos dígitos
    if (parts.length > 1 && parts[1].length > 2) {
      return oldValue;
    }

    return newValue;
  }
}
