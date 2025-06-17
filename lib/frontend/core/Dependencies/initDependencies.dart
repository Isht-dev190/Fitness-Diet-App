import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';  
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_session.dart';

class HiveInitializer {
  // Box names as static constants
  static const String userSessionBox = 'userSessionBox';
  static const String userModelBox = 'userModelBox';
  static const String foodBoxName = 'foods';
  static const String mealBoxName = 'meals';
  static const String exerciseBoxName = 'exercises';
  static const String workoutBoxName = 'workouts';
  static const String fastingBoxName = 'fastings';
  static const String articleBoxName = 'articles';

  // Box instances
  static Box<UserModel>? userBox;
  static Box<Workout>? workoutBox;
  static Box<Exercise>? exerciseBox;
  static Box<Food>? foodBox;
  static Box<Meal>? mealBox;
  static Box<Article>? articleBox;
  static Box<Fasting>? fastingBox;
  static Box<UserSession>? userSessionBoxInstance;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Register adapters in order of dependencies
    // Base models first
    Hive.registerAdapter(UserSessionAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(FoodAdapter());
    Hive.registerAdapter(ExerciseAdapter());
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(FastingAdapter());
    Hive.registerAdapter(WorkoutExerciseAdapter());  
    
    // Dependent models next
    Hive.registerAdapter(WorkoutAdapter());
    Hive.registerAdapter(MealFoodAdapter());
    Hive.registerAdapter(MealAdapter());

    // Open boxes
    userSessionBoxInstance = await Hive.openBox<UserSession>(userSessionBox);
    userBox = await Hive.openBox<UserModel>(userModelBox);
    foodBox = await Hive.openBox<Food>(foodBoxName);
    exerciseBox = await Hive.openBox<Exercise>(exerciseBoxName);
    articleBox = await Hive.openBox<Article>(articleBoxName);
    fastingBox = await Hive.openBox<Fasting>(fastingBoxName);
    
    // Open dependent boxes last
    workoutBox = await Hive.openBox<Workout>(workoutBoxName);
    mealBox = await Hive.openBox<Meal>(mealBoxName);

    print("Hive Initialized, Adapters Registered, and Boxes Opened");
  }

  static Future<void> clearBoxes() async {
    await userSessionBoxInstance?.clear();
    await userBox?.clear();
    await workoutBox?.clear();
    await exerciseBox?.clear();
    await foodBox?.clear();
    await mealBox?.clear();
    await articleBox?.clear();
    await fastingBox?.clear();
  }
}