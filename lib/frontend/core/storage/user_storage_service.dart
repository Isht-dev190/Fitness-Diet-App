import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';

class UserStorageService extends BaseStorageService<UserModel> {
  static final UserStorageService _instance = UserStorageService._internal();
  
  factory UserStorageService() {
    return _instance;
  }
  
  UserStorageService._internal() : super(HiveInitializer.userModelBox);

  Future<void> saveUser(UserModel user) async {
    await add(user.email, user);
  }

  Future<void> updateUser(UserModel user) async {
    await update(user.email, user);
  }

  UserModel? getUser(String email) {
    return get(email);
  }

  Future<void> deleteUser(String email) async {
    await delete(email);
  }

  List<UserModel> getAllUsers() {
    return getAll();
  }

  bool userExists(String email) {
    return exists(email);
  }
} 