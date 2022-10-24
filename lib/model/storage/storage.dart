abstract class Storage {
  Future<String?> getString(String key);
  Future<void> putString(String key, String? value);
  Future<void> put(String key, Object? object);
}
