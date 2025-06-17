import 'package:hive/hive.dart';

part 'user_session.g.dart';

@HiveType(typeId: 0)
class UserSession extends HiveObject {
  @HiveField(0)
  String? email;

  @HiveField(1)
  String? sessionId;

  UserSession({
    this.email,
    this.sessionId,
  });
} 