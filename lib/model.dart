import 'package:money_counter/utils.dart';

class MoneyCounterModel {
  final denominations = denominationValues.map((v) => Denomination(value: v)).toList(growable: false);

  double get total => denominations.map((d) => d.value * d.count).reduce((value, element) => value + element);

  void reset() {
    for (final denomination in denominations) {
      denomination.text = '';
    }
  }
}

final denominationValues = [500, 200, 100, 50, 20, 10, 5, 1];

class Denomination {
  final int value;
  String text;

  Denomination({required this.value, this.text = ''});

  double get count => double.tryParse(text) ?? 0;

  String get label => value == 1 ? 'Coins' : denominationFormatter.format(value);
}
