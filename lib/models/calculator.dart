// ignore_for_file: avoid_print

import 'dart:math';

import 'package:buy_car_rule/models/amortization.dart';

class CarPurchaseCalculator {
  // Variables
  double annualIncome;
  double carPrice;
  double interestRate;
  int loanTermYears;
  double downPaymentPercentage;
  double maxMonthlyPaymentPercentage;
  AmortizationType amortizationType;

  // Constructor
  CarPurchaseCalculator({
    required this.annualIncome,
    required this.carPrice,
    required this.interestRate,
    required this.loanTermYears,
    required this.downPaymentPercentage,
    required this.maxMonthlyPaymentPercentage,
    required this.amortizationType,
  });

  // Método para calcular el pago inicial
  double calculateDownPayment() {
    return carPrice * downPaymentPercentage;
  }

  // Método para calcular el monto del préstamo
  double calculateLoanAmount() {
    return carPrice - calculateDownPayment();
  }

  // Método para calcular el pago mensual
  double calculateMonthlyPayment() {
    double loanAmount = calculateLoanAmount();
    int months = loanTermYears * 12;
    double monthlyInterestRate = interestRate / 100 / 12;
    double monthlyPayment = loanAmount *
        (monthlyInterestRate * pow(1 + monthlyInterestRate, months)) /
        (pow(1 + monthlyInterestRate, months) - 1);
    return monthlyPayment;
  }

  // Método para calcular el pago mensual máximo permitido
  double calculateMaxMonthlyPayment() {
    double monthlyIncome = annualIncome / 12;
    return monthlyIncome * maxMonthlyPaymentPercentage;
  }

  // Método para verificar si el pago mensual está dentro del límite permitido
  bool isPaymentWithinLimit() {
    return calculateMonthlyPayment() <= calculateMaxMonthlyPayment();
  }

  // Método para mostrar los resultados
  void displayResults() {
    print('Annual Income: \$${annualIncome.toStringAsFixed(2)}');
    print('Car Price: \$${carPrice.toStringAsFixed(2)}');
    print('Down Payment: \$${calculateDownPayment().toStringAsFixed(2)}');
    print('Loan Amount: \$${calculateLoanAmount().toStringAsFixed(2)}');
    print('Monthly Payment: \$${calculateMonthlyPayment().toStringAsFixed(2)}');
    print(
        'Max Monthly Payment: \$${calculateMaxMonthlyPayment().toStringAsFixed(2)}');
    print('Is Payment Within Limit: ${isPaymentWithinLimit()}');
  }
}

void main() {
  // Ejemplo de uso de la clase CarPurchaseCalculator
  CarPurchaseCalculator calculator = CarPurchaseCalculator(
    annualIncome: 16611.84,
    carPrice: 24000,
    interestRate: 6.5,
    loanTermYears: 4,
    downPaymentPercentage: 0.20,
    maxMonthlyPaymentPercentage: 0.10,
    amortizationType: AmortizationType.french,
  );

  calculator.displayResults();

  // Generar y mostrar la tabla de amortización
  AmortizationTable amortizationTable = AmortizationTable(calculator);
  var frenchAmortization = amortizationTable.generateFrenchAmortizationTable();
  var germanAmortization = amortizationTable.generateGermanAmortizationTable();

  print('\nFrench Amortization Table:');
  print('Type: ${frenchAmortization['AmortizationType']}');
  print(
      'Total Interest Paid: \$${frenchAmortization['TotalInterestPaid'].toStringAsFixed(2)}');
  print(
      'Total Amount Paid: \$${frenchAmortization['TotalAmountPaid'].toStringAsFixed(2)}');
  print('Month\tPayment\t\tInterest\tPrincipal\tBalance');
  for (var entry in frenchAmortization['AmortizationList']) {
    print(
        '${entry['Month']}\t\t\$${entry['Payment'].toStringAsFixed(2)}\t\t\$${entry['Interest'].toStringAsFixed(2)}\t\t\$${entry['Principal'].toStringAsFixed(2)}\t\t\$${entry['Balance'].toStringAsFixed(2)}');
  }

  print('\nGerman Amortization Table:');
  print('Type: ${germanAmortization['AmortizationType']}');
  print(
      'Total Interest Paid: \$${germanAmortization['TotalInterestPaid'].toStringAsFixed(2)}');
  print(
      'Total Amount Paid: \$${germanAmortization['TotalAmountPaid'].toStringAsFixed(2)}');
  print('Month\tPayment\t\tInterest\tPrincipal\tBalance');
  for (var entry in germanAmortization['AmortizationList']) {
    print(
        '${entry['Month']}\t\t\$${entry['Payment'].toStringAsFixed(2)}\t\t\$${entry['Interest'].toStringAsFixed(2)}\t\t\$${entry['Principal'].toStringAsFixed(2)}\t\t\$${entry['Balance'].toStringAsFixed(2)}');
  }
}
