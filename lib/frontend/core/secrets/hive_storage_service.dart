import '../Models/user_session.dart';
import '../Dependencies/initDependencies.dart';
import '../storage/base_storage_service.dart';

class HiveStorageService extends BaseStorageService<UserSession> {
  static final HiveStorageService _instance = HiveStorageService._internal();
  
  factory HiveStorageService() {
    return _instance;
  }
  
  HiveStorageService._internal() : super(HiveInitializer.userSessionBox);

  Future<void> saveUserSession(String email, String sessionId) async {
    await add('current_session', UserSession(email: email, sessionId: sessionId));
  }

  Future<void> clearUserSession() async {
    await delete('current_session');
  }

  UserSession? getUserSession() {
    return get('current_session');
  }

  bool hasValidSession() {
    final session = getUserSession();
    return session?.sessionId != null && session?.email != null;
  }
} 