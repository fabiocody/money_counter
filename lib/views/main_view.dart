import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:money_counter/model/model.dart';
import 'package:money_counter/service/cron_service.dart';
import 'package:money_counter/utils.dart';
import 'package:money_counter/views/currency_input.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MoneyCounterModel _model = MoneyCounterModel();
  CronJob? _cronJob;

  @override
  void initState() {
    super.initState();
    MoneyCounterModel.load().then(
      (model) => setState(() {
        _model.setFrom(model);
        _cronJob = CronService().schedule(const Duration(seconds: 5), () => _model.save());
        FlutterNativeSplash.remove();
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
      appBar: AppBar(
        title: Text('MoneyCounter', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GestureDetector(
        onTap: () {
          unfocus(context);
          _model.save();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    ..._model.denominations.map(
                      (d) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: CurrencyInput(
                          labelText: d.label,
                          initialText: d.text,
                          allowDecimal: d.value == 1,
                          onChanged: (text) => setState(() => d.text = text),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: FilledButton(
                            onPressed: () => setState(_model.reset),
                            child: const Text('RESET'),
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
                    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
