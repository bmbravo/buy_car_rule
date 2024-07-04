import 'package:buy_car_rule/models/amortization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getAmortizationTypeName(
    AppLocalizations localizations, AmortizationType type) {
  switch (type) {
    case AmortizationType.french:
      return localizations.amortization_french;
    case AmortizationType.german:
      return localizations.amortization_german;
    default:
      return '';
  }
}
