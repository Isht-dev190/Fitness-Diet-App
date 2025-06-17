import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_theme.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/features/Service.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_repo.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_viewModel.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_repo.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_viewModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_dev_fitness_diet/frontend/core/secrets/supabase_secrets.dart';
import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/Router.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_repository.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_service.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: AppSecrets.supabaseURL,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  
  // Initialize Hive and dependencies
  await HiveInitializer.initialize();
  

  runApp(
    MultiProvider(
      providers: [
        // Theme and Auth
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        
        // Exercise services
        ChangeNotifierProvider(create: (_) => ExerciseService()),
        Provider(create: (context) => ExerciseRepository(context.read<ExerciseService>())),
        ChangeNotifierProvider(create: (context) => ExerciseViewModel(context.read<ExerciseRepository>())),
        
        // Food services
        ChangeNotifierProvider(create: (_) => FoodService()),
        Provider(create: (context) => FoodRepository(context.read<FoodService>())),
        ChangeNotifierProvider(create: (context) => FoodViewModel(context.read<FoodRepository>())),
        
        // Workout services
        BlocProvider<WorkoutServiceCubit>(
          create: (_) => WorkoutServiceCubit(HiveInitializer.workoutBox!),
        ),
        Provider<WorkoutRepository>(
          create: (context) => WorkoutRepository(
            context.read<WorkoutServiceCubit>(),
          ),
        ),
        BlocProvider<WorkoutCubit>(
          create: (context) => WorkoutCubit(
            context.read<WorkoutRepository>(),
          ),
        ),
        BlocProvider<AddWorkoutCubit>(
          create: (context) => AddWorkoutCubit(),
        ),
        BlocProvider<MealCubit>(
          create: (_) => MealCubit(HiveInitializer.mealBox!),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Fitness & Diet App',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: router,
          );
        },
      ),
    ),
  );
}
