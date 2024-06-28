import 'package:buy_car_rule/models/amortization.dart';
import 'package:buy_car_rule/models/calculator.dart';
import 'package:buy_car_rule/utils/percentage_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  AmortizationType _selectedAmortization = AmortizationType.french;

  final _anualIncomeController = TextEditingController();
  final _carPriceController = TextEditingController();
  final _dowPaymentController = TextEditingController();
  final _monthlyPaymentController = TextEditingController();
  final _loanTermController = TextEditingController();
  final _interestRateController = TextEditingController();

  void _showDialog({required String errorText}) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Invalid Input'),
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

  void _submitData() {
    var errorText = '';
    final anualIncome = double.tryParse(_anualIncomeController.text);
    final carPrice = double.tryParse(_carPriceController.text);
    final downPayment = double.tryParse(_dowPaymentController.text);
    final monthlyPayment = double.tryParse(_monthlyPaymentController.text);
    final loanTerm = int.tryParse(_loanTermController.text);
    final interestRate = double.tryParse(_interestRateController.text);

    if (anualIncome == null || anualIncome <= 0) {
      errorText = 'Please enter a valid Anual Income';
      _showDialog(errorText: errorText);
      return;
    }

    CarPurchaseCalculator calculatorResults = CarPurchaseCalculator(
      annualIncome: anualIncome,
      carPrice: carPrice!,
      interestRate: interestRate!,
      loanTermYears: loanTerm!,
      downPaymentPercentage: downPayment!,
      maxMonthlyPaymentPercentage: monthlyPayment!,
      amortizationType: _selectedAmortization,
    );
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
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              TextField(
                controller: _anualIncomeController,
                maxLength: 25,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  counterText: '',
                  icon: const Icon(CupertinoIcons.money_dollar),
                  labelText: 'Gross Annual Income',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _carPriceController,
                maxLength: 25,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  counterText: '',
                  icon: const Icon(CupertinoIcons.car_detailed),
                  labelText: 'Car Price',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _dowPaymentController,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                decoration: InputDecoration(
                  icon: const Icon(CupertinoIcons.percent),
                  labelText: 'Down Payment Percentage',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _monthlyPaymentController,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                decoration: InputDecoration(
                  icon: const Icon(CupertinoIcons.percent),
                  labelText: 'Max Monthly Payment Percentage',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _loanTermController,
                maxLength: 2,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  icon: const Icon(CupertinoIcons.time),
                  labelText: 'Loan Term in Years',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _interestRateController,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\,?\d{0,2}')),
                  PercentageInputFormatter(),
                ],
                decoration: InputDecoration(
                  icon: const Icon(CupertinoIcons.percent),
                  labelText: 'Loan Interest Rate',
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(
                      top: 16.0), // Ajusta el valor según sea necesario
                ),
              ),
              const SizedBox(height: 25),
              DropdownButtonHideUnderline(
                child: DropdownButton<AmortizationType>(
                  isExpanded: true,
                  value: _selectedAmortization,
                  items: AmortizationType.values.map((amortization) {
                    return DropdownMenuItem<AmortizationType>(
                      value: amortization,
                      child: Text(
                        amortization.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedAmortization = value;
                    });
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
                              amortization.name.toUpperCase(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
