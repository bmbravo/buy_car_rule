import 'package:buy_car_rule/providers/amortization_result_provider.dart';
import 'package:buy_car_rule/providers/calculator_results_provider.dart';
import 'package:buy_car_rule/widgets/amortization_table.dart';
import 'package:buy_car_rule/widgets/result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorResults = ref.watch(calculatorResultsProvider);
    final amortizationResults = ref.watch(amortizationResultProvider);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ResultCard(
                text: 'Anual Income: \$${calculatorResults['anual_income']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text: 'Car Price: \$${calculatorResults['car_price']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text: 'Down Payment: \$${calculatorResults['down_payment']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text: 'Anual Income: \$${calculatorResults['anual_income']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text: 'Loan Amount: \$${calculatorResults['loan_amount']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    'Maximum Monthly Payment: \$${calculatorResults['max_monthly_payment']}',
              ),
              const SizedBox(height: 10),
              ResultCard(
                text:
                    'Monthly Payment: \$${calculatorResults['monthly_payment']}',
                trailingIcon: Tooltip(
                  showDuration: const Duration(seconds: 30),
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                      ),
                  message: calculatorResults['is_payment_limit'] == true
                      ? 'Your monthly payment is good for your budget'
                      : 'Your monthly payment exceeds your budget',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    CupertinoIcons.info_circle_fill,
                    color: calculatorResults['is_payment_limit'] == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
