import 'dart:math';

import 'package:buy_car_rule/models/calculator.dart';

enum AmortizationType { french, german }

class AmortizationTable {
  CarPurchaseCalculator calculator;

  AmortizationTable(this.calculator);

  // Función para generar la tabla de amortización según el método francés
  Map<String, dynamic> generateFrenchAmortizationTable() {
    double loanAmount = calculator.calculateLoanAmount();
    double monthlyInterestRate = calculator.interestRate / 100 / 12;
    int totalPayments = calculator.loanTermYears * 12;

    double monthlyPayment = loanAmount *
        monthlyInterestRate /
        (1 - pow(1 + monthlyInterestRate, -totalPayments));

    double balance = loanAmount;
    double totalInterest = 0;

    List<Map<String, String>> amortizationList = [];

    for (int month = 1; month <= totalPayments; month++) {
      double interestPayment = balance * monthlyInterestRate;
      double principalPayment = monthlyPayment - interestPayment;
      balance -= principalPayment;
      totalInterest += interestPayment;

      amortizationList.add({
        'Month': month.toString(),
        'Payment': monthlyPayment.toStringAsFixed(2),
        'Interest': interestPayment.toStringAsFixed(2),
        'Principal': principalPayment.toStringAsFixed(2),
        'Balance': balance.toStringAsFixed(2),
      });
    }

    return {
      'AmortizationType': AmortizationType.french,
      'TotalInterestPaid': totalInterest.toStringAsFixed(2),
      'TotalAmountPaid': (loanAmount + totalInterest).toStringAsFixed(2),
      'AmortizationList': amortizationList,
    };
  }

  // Función para generar la tabla de amortización según el método alemán
  Map<String, dynamic> generateGermanAmortizationTable() {
    double loanAmount = calculator.calculateLoanAmount();
    double monthlyPrincipalPayment =
        loanAmount / (calculator.loanTermYears * 12);
    double monthlyInterestRate = calculator.interestRate / 100 / 12;
    int totalPayments = calculator.loanTermYears * 12;

    double balance = loanAmount;
    double totalInterest = 0;

    List<Map<String, String>> amortizationList = [];

    for (int month = 1; month <= totalPayments; month++) {
      double interestPayment = balance * monthlyInterestRate;
      double monthlyPayment = monthlyPrincipalPayment + interestPayment;
      balance -= monthlyPrincipalPayment;
      totalInterest += interestPayment;

      amortizationList.add({
        'Month': month.toString(),
        'Payment': monthlyPayment.toStringAsFixed(2),
        'Interest': interestPayment.toStringAsFixed(2),
        'Principal': monthlyPrincipalPayment.toStringAsFixed(2),
        'Balance': balance.toStringAsFixed(2),
      });
    }

    return {
      'AmortizationType': AmortizationType.german,
      'TotalInterestPaid': totalInterest.toStringAsFixed(2),
      'TotalAmountPaid': (loanAmount + totalInterest).toStringAsFixed(2),
      'AmortizationList': amortizationList,
    };
  }
}
