import 'package:hive/hive.dart';

part 'meal_foods.g.dart';

@HiveType(typeId: 9)
class MealFoods {
  

  @HiveField(0)
  String foodName;

  @HiveField(1)
  String portionAmount;

  @HiveField(2)
  String portionUnit;



  MealFoods({
    required this.foodName,
    required this.portionAmount,
    required this.portionUnit,
   
  });

  factory MealFoods.fromJson(Map<String, dynamic> json) {
    return MealFoods(
      foodName: json['food_name'] ?? {},
      portionAmount: json['portion_amount'] ?? '',
      portionUnit: json['portion_unit'] ?? '',
    );  
  }
    Map<String, dynamic> toJson() {
    return {
      "food_name": foodName,
      "portion_amount": portionAmount,
      "portion_unit": portionUnit,
    };
  }

}
