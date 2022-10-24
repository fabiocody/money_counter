import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:money_counter/model/storage/storage.dart';

abstract class HiveStorage extends Storage {
  Future<LazyBox<String>> openBox();

  @override
  Future<String?> getString(String key) async {
    final box = await openBox();
    return box.get(key);
  }

  @override
  Future<void> put(String key, Object? object) {
    final String? value = object != null ? jsonEncode(object) : null;
    return putString(key, value);
  }

  @override
  Future<void> putString(String key, String? value) async {
    final box = await openBox();
    if (value != null) {
      await box.put(key, value);
    } else {
      await box.delete(key);
    }
  }
}
