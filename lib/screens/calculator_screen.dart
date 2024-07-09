import 'dart:io';

import 'package:buy_car_rule/models/amortization.dart';
import 'package:buy_car_rule/models/calculator.dart';
import 'package:buy_car_rule/providers/amortization_result_provider.dart';
import 'package:buy_car_rule/providers/calculator_form_provider.dart';
import 'package:buy_car_rule/providers/calculator_results_provider.dart';
import 'package:buy_car_rule/utils/amortization_type.dart';
import 'package:buy_car_rule/utils/percentage_input_formatter.dart';
import 'package:buy_car_rule/widgets/calculator_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key, required this.onSelectScreen});

  final void Function(int index) onSelectScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _anualIncomeController = TextEditingController();
  final _carPriceController = TextEditingController();
  final _dowPaymentController = TextEditingController();
  final _monthlyPaymentController = TextEditingController();
  final _loanTermController = TextEditingController();
  final _interestRateController = TextEditingController();

  String? validateField(String fieldName, double? value) {
    if (value == null || value <= 0) {
      return '${AppLocalizations.of(context)!.enterValidText} $fieldName';
    }
    return null;
  }

  void _showDialog({required String errorText}) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.invalidInput),
          content: Text(errorText),
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
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.invalidInput),
          content: Text(errorText),
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

  void _showDialogInfo(String text) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          // title: Text(AppLocalizations.of(context)!.infoDialogTitle),
          content: Text(text),
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
          title: Text(AppLocalizations.of(context)!.infoDialogTitle),
          content: Text(text),
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
    }
  }

  @override
  void dispose() {
    _anualIncomeController.dispose();
    _carPriceController.dispose();
    _dowPaymentController.dispose();
    _monthlyPaymentController.dispose();
    _loanTermController.dispose();
    _interestRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calculatorResultsNotifier =
        ref.read(calculatorResultsProvider.notifier);

    final amortizationResultsNotifier =
        ref.read(amortizationResultProvider.notifier);

    final calculatorFormState = ref.watch(calculatorFormProvider);
    final calculatorFormNotifier = ref.read(calculatorFormProvider.notifier);

    _anualIncomeController.text = calculatorFormState['anualIncome'];
    _carPriceController.text = calculatorFormState['carPrice'];
    _dowPaymentController.text = calculatorFormState['downPayment'];
    _monthlyPaymentController.text = calculatorFormState['maxMonthlyPayment'];
    _loanTermController.text = calculatorFormState['loanTerm'];
    _interestRateController.text = calculatorFormState['loanInterestRate'];

    void submitData() async {
      final anualIncome = double.tryParse(calculatorFormState['anualIncome']);
      final carPrice = double.tryParse(calculatorFormState['carPrice']);
      final downPayment = double.tryParse(calculatorFormState['downPayment']);
      final monthlyPayment =
          double.tryParse(calculatorFormState['maxMonthlyPayment']);
      final loanTerm = int.tryParse(calculatorFormState['loanTerm']);
      final interestRate =
          double.tryParse(calculatorFormState['loanInterestRate']);

      String? errorText;

      errorText = validateField(
          AppLocalizations.of(context)!.anualIncomeResultsText, anualIncome);
      if (errorText != null) {
        _showDialog(errorText: errorText);
        return;
      }

      errorText = validateField(
          AppLocalizations.of(context)!.carPriceResultsText, carPrice);
      if (errorText != null) {
        _showDialog(errorText: errorText);
        return;
      }

      errorText = validateField(
          AppLocalizations.of(context)!.downPaymentResultsText, downPayment);
      if (errorText != null) {
        _showDialog(errorText: errorText);
        return;
      }

      errorText = validateField(
          AppLocalizations.of(context)!.maxMonthlyPaymentResultsText,
          monthlyPayment);
      if (errorText != null) {
        _showDialog(errorText: errorText);
        return;
      }

      if (loanTerm == null || loanTerm <= 0) {
        errorText =
            '${AppLocalizations.of(context)!.enterValidText} ${AppLocalizations.of(context)!.loanTermTextField}';
        _showDialog(errorText: errorText);
        return;
      }

      errorText = validateField(
          AppLocalizations.of(context)!.interestRateTextField, interestRate);
      if (errorText != null) {
        _showDialog(errorText: errorText);
        return;
      }

      try {
        CarPurchaseCalculator calculator = CarPurchaseCalculator(
          annualIncome: anualIncome!,
          carPrice: carPrice!,
          interestRate: interestRate!,
          loanTermYears: loanTerm,
          downPaymentPercentage: downPayment! / 100,
          maxMonthlyPaymentPercentage: monthlyPayment! / 100,
          amortizationType: calculatorFormState['amortizationType'],
        );

        final results = calculator.getResults();

        calculatorResultsNotifier.setAnnualIncome(results['anual_income']);
        calculatorResultsNotifier.setCarPrice(results['car_price']);
        calculatorResultsNotifier.setDownPayment(results['dow_payment']);
        calculatorResultsNotifier.setLoanAmount(results['loan_amount']);
        calculatorResultsNotifier.setMonthlyPayment(results['monthly_payment']);
        calculatorResultsNotifier
            .setMaxMonthlyPayment(results['max_monthly_payment']);
        calculatorResultsNotifier
            .setIsPaymentLimit(results['is_payment_limit']);

        Map<String, dynamic> amortizationResult;

        AmortizationTable amortizationTable = AmortizationTable(calculator);
        if (calculatorFormState['amortizationType'] ==
            AmortizationType.french) {
          amortizationResult =
              amortizationTable.generateFrenchAmortizationTable();
        } else {
          amortizationResult =
              amortizationTable.generateGermanAmortizationTable();
        }

        amortizationResultsNotifier
            .setAmortizationType(amortizationResult['AmortizationType']);
        amortizationResultsNotifier
            .setTotalAmountPaid(amortizationResult['TotalAmountPaid']);
        amortizationResultsNotifier
            .setTotalInterestPaid(amortizationResult['TotalInterestPaid']);
        amortizationResultsNotifier
            .setAmortizationList(amortizationResult['AmortizationList']);

        widget.onSelectScreen(2);
      } on Exception catch (e) {
        _showDialog(errorText: 'An error ocurred please try again later: $e');
      }
    }

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              CalculatorInput(
                textController: _anualIncomeController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  calculatorFormNotifier.setAnualIncome(value);
                },
                labelText: AppLocalizations.of(context)!.anualIncomeTextField,
                icon: const Icon(CupertinoIcons.money_dollar),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                maxLength: 25,
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(
                        AppLocalizations.of(context)!.anualIncomeInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CalculatorInput(
                textController: _carPriceController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  calculatorFormNotifier.setCarPrice(value);
                },
                labelText: AppLocalizations.of(context)!.carPriceTextField,
                icon: const Icon(CupertinoIcons.car_detailed),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                maxLength: 25,
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(AppLocalizations.of(context)!.carPriceInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CalculatorInput(
                textController: _dowPaymentController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  String sanitizedValue = value.replaceAll(',', '.');
                  // Actualizar el valor en el controlador
                  _dowPaymentController.value =
                      _dowPaymentController.value.copyWith(
                    text: sanitizedValue,
                    selection:
                        TextSelection.collapsed(offset: sanitizedValue.length),
                  );
                  calculatorFormNotifier.setDownPayment(sanitizedValue);
                },
                labelText: AppLocalizations.of(context)!.downPaymentTextField,
                icon: const Icon(CupertinoIcons.percent),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(
                        AppLocalizations.of(context)!.downPaymentInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CalculatorInput(
                textController: _monthlyPaymentController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  String sanitizedValue = value.replaceAll(',', '.');
                  // Actualizar el valor en el controlador
                  _monthlyPaymentController.value =
                      _monthlyPaymentController.value.copyWith(
                    text: sanitizedValue,
                    selection:
                        TextSelection.collapsed(offset: sanitizedValue.length),
                  );
                  calculatorFormNotifier.setMaxMonthlyPayment(sanitizedValue);
                },
                labelText:
                    AppLocalizations.of(context)!.monthlyPaymentTextField,
                icon: const Icon(CupertinoIcons.percent),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(
                        AppLocalizations.of(context)!.maxMonthlyPaymentInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CalculatorInput(
                textController: _loanTermController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  calculatorFormNotifier.setLoanTerm(value);
                },
                labelText: AppLocalizations.of(context)!.loanTermTextField,
                icon: const Icon(CupertinoIcons.time),
                keyboardType: TextInputType.number,
                maxLength: 2,
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(AppLocalizations.of(context)!.loanTermInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CalculatorInput(
                textController: _interestRateController,
                onChanged: (value) {
                  if (value.isEmpty) return;
                  String sanitizedValue = value.replaceAll(',', '.');
                  // Actualizar el valor en el controlador
                  _interestRateController.value =
                      _interestRateController.value.copyWith(
                    text: sanitizedValue,
                    selection:
                        TextSelection.collapsed(offset: sanitizedValue.length),
                  );
                  calculatorFormNotifier.setLoanInterestRate(sanitizedValue);
                },
                labelText: AppLocalizations.of(context)!.interestRateTextField,
                icon: const Icon(CupertinoIcons.percent),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                suffixIcon: IconButton(
                  onPressed: () {
                    _showDialogInfo(
                        AppLocalizations.of(context)!.interestRateInfo);
                  },
                  icon: const Icon(
                    CupertinoIcons.info,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              DropdownButtonHideUnderline(
                child: DropdownButton<AmortizationType>(
                  isExpanded: true,
                  value: calculatorFormState['amortizationType'],
                  items: AmortizationType.values.map((amortization) {
                    return DropdownMenuItem<AmortizationType>(
                      value: amortization,
                      child: Text(
                        '${AppLocalizations.of(context)!.typeOfAmortization}: ${getAmortizationTypeName(AppLocalizations.of(context)!, amortization)}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    calculatorFormNotifier.setAmortizationType(value);
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return AmortizationType.values.map<Widget>((amortization) {
                      return Stack(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(CupertinoIcons.table),
                          ),
                          Center(
                            child: Text(
                              getAmortizationTypeName(
                                  AppLocalizations.of(context)!, amortization),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: submitData,
                  child: Text(
                    AppLocalizations.of(context)!.calculateButtonText,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
