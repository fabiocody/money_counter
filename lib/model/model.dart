import 'dart:convert';

import 'package:money_counter/model/denomination/denomination.dart';
import 'package:money_counter/model/storage/generic_storage.dart';

class MoneyCounterModel {
  final List<Denomination> denominations;

  MoneyCounterModel([List<Denomination>? denominations])
      : denominations = denominations ??
            [500, 200, 100, 50, 20, 10, 5, 1].map((v) => Denomination(value: v)).toList(growable: false);

  double get total => denominations.map((d) => d.value * d.count).reduce((value, element) => value + element);

  void reset() {
    for (final denomination in denominations) {
      denomination.text = '';
    }
    save();
  }

  static Future<MoneyCounterModel> load() async {
    final modelString = await GenericStorage().getString('denominations');
    if (modelString == null || modelString.isEmpty) return MoneyCounterModel();
    final List<Denomination> denominations =
        List<Denomination>.from(jsonDecode(modelString).map((d) => Denomination.fromJson(d)));
    return MoneyCounterModel(denominations);
  }

  Future<void> save() async {
    return GenericStorage().put('denominations', denominations);
  }
}
