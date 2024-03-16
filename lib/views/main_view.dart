import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:money_counter/service/denominations_provider.dart';
import 'package:money_counter/utils.dart';
import 'package:money_counter/views/currency_input.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () async {
      ref.read(denominationsProvider.notifier).load();
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    final denominations = ref.watch(denominationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('MoneyCounter', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GestureDetector(
        onTap: () => unfocus(context),
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
                    ...denominations.map(
                      (d) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: CurrencyInput(
                          labelText: d.label,
                          initialText: d.text,
                          allowDecimal: d.value == 1,
                          onChanged: (text) => ref.read(denominationsProvider.notifier).set(d.value, text),
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
                            onPressed: () => ref.read(denominationsProvider.notifier).reset(),
                            child: const Text('RESET'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                currencyFormatter.format(ref.watch(totalProvider)),
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
