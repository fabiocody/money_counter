import 'package:money_counter/utils.dart';

class Denomination {
  final int value;
  final String text;

  const Denomination({required this.value, this.text = ''});

  double get count => double.tryParse(text.replaceAll(',', '.')) ?? 0;

  String get label => value == 1 ? 'Coins' : denominationFormatter.format(value);

  Denomination copyWith({
    String? text,
  }) =>
      Denomination(
        value: value,
        text: text ?? this.text,
      );
}
