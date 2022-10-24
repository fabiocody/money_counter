import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void unfocus(BuildContext context) {
  final currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

final currencyFormatter = NumberFormat.simpleCurrency(locale: 'it', decimalDigits: 2);
final denominationFormatter = NumberFormat.simpleCurrency(locale: 'it', decimalDigits: 0);
