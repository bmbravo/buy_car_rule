import 'package:buy_car_rule/models/amortization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmortizationResultNotifier extends StateNotifier<Map<String, dynamic>> {
  AmortizationResultNotifier()
      : super({
          'AmortizationType': 'None',
          'TotalInterestPaid': '0.0',
          'TotalAmountPaid': '0.0',
          'AmortizationList': <Map<String, String>>[],
        });

  void setAmortizationType(AmortizationType value) {
    state = {...state, 'AmortizationType': value};
  }

  void setTotalInterestPaid(String value) {
    state = {...state, 'TotalInterestPaid': value};
  }

  void setTotalAmountPaid(String value) {
    state = {...state, 'TotalAmountPaid': value};
  }

  void setAmortizationList(List<Map<String, String>> value) {
    state = {...state, 'AmortizationList': value};
  }
}

final amortizationResultProvider =
    StateNotifierProvider<AmortizationResultNotifier, Map<String, dynamic>>(
        (ref) {
  return AmortizationResultNotifier();
});
