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

int getFirstDifferenceIndex(String s1, String s2) {
  final minLength = s1.length < s2.length ? s1.length : s2.length;
  for (var i = 0; i < minLength; i++) {
    if (s1[i] != s2[i]) {
      return i;
    }
  }
  return minLength;
}
