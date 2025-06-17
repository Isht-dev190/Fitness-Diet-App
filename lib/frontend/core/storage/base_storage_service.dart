import 'package:hive/hive.dart';

abstract class BaseStorageService<T> {
  final String boxName;
  
  const BaseStorageService(this.boxName);

  Box<T> get box => Hive.box<T>(boxName);

  Future<void> add(String key, T value) async {
    await box.put(key, value);
  }

  Future<void> addAll(Map<String, T> entries) async {
    await box.putAll(entries);
  }

  T? get(String key) {
    return box.get(key);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    await box.clear();
  }

  bool exists(String key) {
    return box.containsKey(key);
  }

  Future<void> update(String key, T value) async {
    if (exists(key)) {
      await box.put(key, value);
    }
  }

  Stream<BoxEvent> watch({String? key}) {
    return key != null ? box.watch(key: key) : box.watch();
  }
} 