import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorResultsNotifier extends StateNotifier<Map<String, dynamic>> {
  CalculatorResultsNotifier()
      : super({
          'anual_income': '0.0',
          'car_price': '0.0',
          'down_payment': '0.0',
          'loan_amount': '0.0',
          'monthly_payment': '0.0',
          'max_monthly_payment': '0.0',
          'is_payment_limit': false,
        });

  void setAnnualIncome(String value) {
    state = {...state, 'anual_income': value};
  }

  void setCarPrice(String value) {
    state = {...state, 'car_price': value};
  }

  void setDownPayment(String value) {
    state = {...state, 'down_payment': value};
  }

  void setLoanAmount(String value) {
    state = {...state, 'loan_amount': value};
  }

  void setMonthlyPayment(String value) {
    state = {...state, 'monthly_payment': value};
  }

  void setMaxMonthlyPayment(String value) {
    state = {...state, 'max_monthly_payment': value};
  }

  void setIsPaymentLimit(bool value) {
    state = {...state, 'is_payment_limit': value};
  }
}

final calculatorResultsProvider =
    StateNotifierProvider<CalculatorResultsNotifier, Map<String, dynamic>>(
        (ref) {
  return CalculatorResultsNotifier();
});
