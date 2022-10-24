import 'package:hive/hive.dart';
import 'package:money_counter/model/storage/hive_storage.dart';

class GenericStorage extends HiveStorage {
  static final GenericStorage _instance = GenericStorage._();
  static const _boxName = 'GenericStorage';

  GenericStorage._();

  factory GenericStorage() => _instance;

  @override
  Future<LazyBox<String>> openBox() async {
    // If the box is already open, it just returns the box
    return Hive.openLazyBox<String>(_boxName);
  }
}
