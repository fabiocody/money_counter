import 'package:flutter/material.dart';
import 'package:money_counter/model.dart';
import 'package:money_counter/utils.dart';
import 'package:money_counter/validation.dart';
import 'package:money_counter/views/currency_input.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final model = MoneyCounterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoneyCounter')),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...model.denominations
                    .map(
                      (d) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: CurrencyInput(
                          labelText: d.label,
                          initialText: d.text,
                          validators: [optionalValidator(d.value == 1 ? decimalValidator : numberValidator)],
                          onChanged: (text) => setState(() => d.text = text),
                        ),
                      ),
                    )
                    .toList(growable: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: ElevatedButton(onPressed: () => setState(model.reset), child: const Text('RESET')),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            currencyFormatter.format(model.total),
                            style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
