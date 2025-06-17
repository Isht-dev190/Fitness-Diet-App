import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 6)
class Food {
  @HiveField(0)
  String name;

  @HiveField(1)
  int portionSize;

  @HiveField(2)
  int calories;

  @HiveField(3)
  double protein;

  @HiveField(4)
  double carbs;

  @HiveField(5)
  double fats;

  @HiveField(6)
  String imageUrl;

  @HiveField(7)
  String category;

  @HiveField(8)
  String description;

  Food({
    required this.name,
    required this.portionSize,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? '',
      portionSize: json['portion_size'] ?? 0,
      calories: json['calories'] ?? 0,
      protein: (json['protein'] ?? 0.0).toDouble(),
      carbs: (json['carbs'] ?? 0.0).toDouble(),
      fats: (json['fats'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'portion_size': portionSize,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'image_url': imageUrl,
      'category': category,
      'description': description,
    };
  }
}
