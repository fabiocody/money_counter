import 'package:json_annotation/json_annotation.dart';
import 'package:money_counter/utils.dart';

part 'denomination.g.dart';

@JsonSerializable()
class Denomination {
  final int value;
  String text;

  Denomination({required this.value, this.text = ''});

  double get count => double.tryParse(text) ?? 0;

  String get label => value == 1 ? 'Coins' : denominationFormatter.format(value);

  factory Denomination.fromJson(Map<String, dynamic> json) => _$DenominationFromJson(json);

  Map<String, dynamic> toJson() => _$DenominationToJson(this);
}
