import 'package:hive/hive.dart';

part 'fasting_model.g.dart';

@HiveType(typeId: 5)
class Fasting {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  @HiveField(3)
  int durationMinutes;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  String userEmail;

  Fasting({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.isCompleted,
    required this.userEmail,
  });

  factory Fasting.fromJson(Map<String, dynamic> json) {
    return Fasting(
      id: json['id'] ?? '',
      startTime: DateTime.parse(json['start_time'] ?? DateTime.now().toString()),
      endTime: DateTime.parse(json['end_time'] ?? DateTime.now().toString()),
      durationMinutes: json['duration_minutes'] ?? 0,
      isCompleted: json['is_completed'] ?? false,
      userEmail: json['user_email'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'duration_minutes': durationMinutes,
      'is_completed': isCompleted,
      'user_email': userEmail,
    };
  }
}
