import 'package:buy_car_rule/models/amortization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorFormNotifier extends StateNotifier<Map<String, dynamic>> {
  CalculatorFormNotifier()
      : super({
          'anualIncome': '20000',
          'carPrice': '5000',
          'downPayment': '20',
          'maxMonthlyPayment': '10',
          'loanTerm': '4',
          'loanInterestRate': '6',
          'amortizationType': AmortizationType.french,
        });

  void reset() {
    state = {
      'anualIncome': '',
      'carPrice': '',
      'downPayment': '',
      'maxMonthlyPayment': '',
      'loanTerm': '',
      'loanInterestRate': '',
      'amortizationType': AmortizationType.french,
    };
  }

  void setAnualIncome(String value) {
    state = {...state, 'anualIncome': value};
  }

  void setCarPrice(String value) {
    state = {...state, 'carPrice': value};
  }

  void setDownPayment(String value) {
    state = {...state, 'downPayment': value};
  }

  void setMaxMonthlyPayment(String value) {
    state = {...state, 'maxMonthlyPayment': value};
  }

  void setLoanTerm(String value) {
    state = {...state, 'loanTerm': value};
  }

  void setLoanInterestRate(String value) {
    state = {...state, 'loanInterestRate': value};
  }

  void setAmortizationType(AmortizationType value) {
    state = {...state, 'amortizationType': value};
  }
}

final calculatorFormProvider =
    StateNotifierProvider<CalculatorFormNotifier, Map<String, dynamic>>((ref) {
  return CalculatorFormNotifier();
});
