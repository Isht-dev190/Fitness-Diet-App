import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';
import 'package:hive/hive.dart';

class FastingStorageService extends BaseStorageService<Fasting> {
  static final FastingStorageService _instance = FastingStorageService._internal();
  
  factory FastingStorageService() {
    return _instance;
  }
  
  FastingStorageService._internal() : super(HiveInitializer.fastingBoxName);

  Future<void> saveFasting(Fasting fasting) async {
    await add(fasting.id, fasting);
  }

  Future<void> updateFasting(Fasting fasting) async {
    await update(fasting.id, fasting);
  }

  Fasting? getFasting(String id) {
    return get(id);
  }

  List<Fasting> getUserFastings(String userEmail) {
    return getAll().where((fasting) => fasting.userEmail == userEmail).toList();
  }

  Future<void> deleteFasting(String id) async {
    await delete(id);
  }

  Future<void> deleteUserFastings(String userEmail) async {
    final userFastings = getUserFastings(userEmail);
    for (final fasting in userFastings) {
      await delete(fasting.id);
    }
  }

  List<Fasting> getAllFastings() {
    return getAll();
  }

  bool fastingExists(String id) {
    return exists(id);
  }

  Stream<BoxEvent> watchUserFastings(String userEmail) {
    return watch();
  }
} 