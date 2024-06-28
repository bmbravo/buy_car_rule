import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmortizationResultNotifier extends StateNotifier<Map<String, dynamic>> {
  AmortizationResultNotifier()
      : super({
          'AmortizationType': 'None',
          'TotalInterestPaid': '0.0',
          'TotalAmountPaid': '0.0',
          'AmortizationList': <Map<String, dynamic>>[],
        });

  void setAmortizationType(String value) {
    state = {...state, 'AmortizationType': value};
  }

  void setTotalInterestPaid(String value) {
    state = {...state, 'TotalInterestPaid': value};
  }

  void setTotalAmountPaid(String value) {
    state = {...state, 'TotalAmountPaid': value};
  }

  void setAmortizationList(List<Map<String, dynamic>> value) {
    state = {...state, 'AmortizationList': value};
  }
}

final amortizationResultProvider =
    StateNotifierProvider<AmortizationResultNotifier, Map<String, dynamic>>(
        (ref) {
  return AmortizationResultNotifier();
});
