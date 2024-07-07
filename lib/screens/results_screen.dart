import 'dart:io';

import 'package:buy_car_rule/providers/amortization_result_provider.dart';
import 'package:buy_car_rule/providers/calculator_results_provider.dart';
import 'package:buy_car_rule/utils/amortization_type.dart';
import 'package:buy_car_rule/widgets/amortization_table.dart';
import 'package:buy_car_rule/widgets/result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key, required this.onSelectScreen});

  final void Function(int index) onSelectScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ResultsScreenState();
  }
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final calculatorResults = ref.watch(calculatorResultsProvider);
    final amortizationResults = ref.watch(amortizationResultProvider);

    void showDialogBudget() {
      String textDialog = calculatorResults['is_payment_limit'] == true
          ? AppLocalizations.of(context)!.budgetGood
          : AppLocalizations.of(context)!.budgetBad;

      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.budgetAlert),
            content: Text(textDialog),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Budget Status'),
            content: Text(textDialog),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
    }

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: const Icon(CupertinoIcons.arrow_left),
                iconAlignment: IconAlignment.start,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                onPressed: () {
                  widget.onSelectScreen(0);
                },
                label: Text(
                  AppLocalizations.of(context)!.goBack,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.calculatorResults,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.anualIncomeResultsText}: \$${calculatorResults['anual_income']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.carPriceResultsText}: \$${calculatorResults['car_price']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.downPaymentResultsText}: \$${calculatorResults['down_payment']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.loanAmountResultsText}: \$${calculatorResults['loan_amount']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.maxMonthlyPaymentResultsText}: \$${calculatorResults['max_monthly_payment']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.monthlyPaymentResultsText}: \$${calculatorResults['monthly_payment']}',
                trailingIcon: GestureDetector(
                  onTap: showDialogBudget,
                  child: Icon(
                    CupertinoIcons.info_circle_fill,
                    color: calculatorResults['is_payment_limit'] == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.loanResults,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.amortizationTypeResultsText}: ${getAmortizationTypeName(
                  AppLocalizations.of(context)!,
                  amortizationResults['AmortizationType'],
                )}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.totalInterestResultsText}: \$${amortizationResults['TotalInterestPaid']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    '${AppLocalizations.of(context)!.toalLoanAmountResultsText}: \$${amortizationResults['TotalAmountPaid']}',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: AmortizationTableWidget(
                  amortizationData: amortizationResults['AmortizationList'],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
