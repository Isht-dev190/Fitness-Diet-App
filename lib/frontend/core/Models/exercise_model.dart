import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  String name;

  @HiveField(1)
  String category;

  @HiveField(2)
  String description;

  @HiveField(3)
  String iconSvg;

  @HiveField(4)
  String videoUrl;

  Exercise({
    required this.name,
    required this.category,
    required this.description,
    required this.iconSvg,
    required this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      iconSvg: json['icon_svg'] ?? '',
      videoUrl: json['video_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'icon_svg': iconSvg,
      'video_url': videoUrl,
    };
  }
}
