import 'package:hive/hive.dart';
import 'package:money_counter/model/denomination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'denominations_provider.g.dart';

const _denominationsBoxName = 'denominations';

@Riverpod(keepAlive: true)
class Denominations extends _$Denominations {
  @override
  List<Denomination> build() => [500, 200, 100, 50, 20, 10, 5, 1].map((v) => Denomination(value: v)).toList();

  Future<Box<String>> _openBox() => Hive.openBox<String>(_denominationsBoxName);

  Future<void> load() async {
    final box = await _openBox();
    final newState = <Denomination>[];
    for (final denomination in state) {
      final data = box.get(denomination.value);
      if (data != null) {
        newState.add(denomination.copyWith(text: data));
      } else {
        newState.add(denomination);
      }
    }
    state = newState;
  }

  Future<void> set(int value, String text) async {
    final box = await _openBox();
    await box.put(value, text);
    state = state.map((d) => d.value == value ? d.copyWith(text: text) : d).toList();
  }

  Future<void> reset() async {
    final box = await _openBox();
    await box.clear();
    state = build();
  }
}

@riverpod
double total(TotalRef ref) => ref.watch(denominationsProvider).fold(0, (prev, d) => prev + d.count * d.value);
