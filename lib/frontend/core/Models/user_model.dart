import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 11)
class UserModel {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  @HiveField(2)
  String age;

  @HiveField(3)
  String gender;

  @HiveField(4)
  int height;

  @HiveField(5)
  int weight;

  @HiveField(6)
  String lifestyle;

  @HiveField(7)
  int bmi;

  @HiveField(8)
  int tdee;

  UserModel({
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.lifestyle,
    required this.bmi,
    required this.tdee,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      age: json['age']?.toString() ?? '', // keep as string
      gender: json['gender'] ?? '',
      height: int.tryParse(json['height']?.toString() ?? '') ?? 0,
      weight: int.tryParse(json['weight']?.toString() ?? '') ?? 0,
      lifestyle: json['lifestyle'] ?? '',
      bmi: int.tryParse(json['bmi']?.toString() ?? '') ?? 0,
      tdee: int.tryParse(json['tdee']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "age": age,
      "gender": gender,
      "height": height,
      "weight": weight,
      "lifestyle": lifestyle,
      "bmi": bmi,
      "tdee": tdee
    };
  }
}
