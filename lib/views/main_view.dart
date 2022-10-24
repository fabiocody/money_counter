import 'package:flutter/material.dart';
import 'package:money_counter/model/model.dart';
import 'package:money_counter/service/cron_service.dart';
import 'package:money_counter/utils.dart';
import 'package:money_counter/validation.dart';
import 'package:money_counter/views/currency_input.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final MoneyCounterModel _model;
  bool _loading = true;
  CronJob? _cronJob;

  @override
  void initState() {
    super.initState();
    MoneyCounterModel.load().then(
      (model) => setState(() {
        _model = model;
        _loading = false;
        _cronJob = CronService().schedule(const Duration(seconds: 5), () => _model.save());
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_cronJob != null) CronService().cancel(_cronJob!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoneyCounter')),
      body: GestureDetector(
        onTap: () {
          unfocus(context);
          _model.save();
        },
        child: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            ..._model.denominations
                                .map(
                                  (d) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: CurrencyInput(
                                      labelText: d.label,
                                      initialText: d.text,
                                      validators: [
                                        optionalValidator(d.value == 1 ? decimalValidator : numberValidator),
                                      ],
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
                                    child: ElevatedButton(
                                      onPressed: () => setState(_model.reset),
                                      child: const Text('RESET'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        currencyFormatter.format(_model.total),
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
                ),
        ),
      ),
    );
  }
}
