import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/preSignInScreen.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signIn/signInView.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regAge/regAgeView.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regGender/regGenderView.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regHeight/regHeightView.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regNameEmail/regNameEmailView.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regWeight/regWeightView.dart';
import 'package:app_dev_fitness_diet/frontend/features/dashboard/dashboard.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_view.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_view.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/foods_view.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_list_screen.dart';
import 'package:app_dev_fitness_diet/frontend/features/intermittent%20fasting/fasting_view.dart';
import 'package:app_dev_fitness_diet/frontend/features/Service.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_repo.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_viewModel.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_list_view.dart';
import 'package:hive/hive.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_service.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_repository.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    // If auth is not initialized, don't redirect
    if (!authService.isInitialized) {
      return null;
    }

    final isGoingToAuth = state.matchedLocation == '/' ||
        state.matchedLocation == '/sign-in' ||
        state.matchedLocation.startsWith('/register');

    final hasValidSession = authService.currentUser != null;

    if (!hasValidSession && !isGoingToAuth) {
      return '/';
    }

    if (hasValidSession && isGoingToAuth) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    // Auth Routes
    GoRoute(
      path: '/',
      builder: (context, state) => PreSignInScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInPage(),
    ),
    // Registration Flow Routes
    GoRoute(
      path: '/register-age',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
        ],
        child: RegAgeView(),
      ),
    ),
    GoRoute(
      path: '/register-gender',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
        ],
        child: const RegGenderView(),
      ),
    ),
    GoRoute(
      path: '/register-height',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
        ],
        child: RegHeightView(),
      ),
    ),
    GoRoute(
      path: '/register-weight',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
        ],
        child: RegWeightView(),
      ),
    ),
    GoRoute(
      path: '/register-name',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
        ],
        child: RegEmail(),
      ),
    ),
    // Main App Shell Route, for nesting across the app and share ui components
    ShellRoute(
      builder: (context, state, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TipsService()),
            Provider<TipsRepository>(
              create: (context) => TipsRepository(context.read<TipsService>()),
            ),
            ChangeNotifierProvider<TipsViewModel>(
              create: (context) => TipsViewModel(context.read<TipsRepository>()),
            ),
            BlocProvider(
              create: (context) {
                final workoutBox = Hive.box<Workout>('workouts');
                final workoutService = WorkoutServiceCubit(workoutBox);
                final workoutRepository = WorkoutRepository(workoutService);
                return WorkoutCubit(workoutRepository);
              },
            ),
            BlocProvider(create: (_) => AddWorkoutCubit()),
            BlocProvider(
              create: (context) {
                final mealBox = Hive.box<Meal>('meals');
                return MealCubit(mealBox);
              },
            ),
          ],
          child: Dashboard(
            currentRoute: state.matchedLocation,
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const SizedBox.shrink(),
        ),
        GoRoute(
          path: '/dashboard/workouts',
          builder: (context, state) => const WorkoutListScreen(),
        ),
        GoRoute(
          path: '/dashboard/exercises',
          builder: (context, state) => const ExerciseView(),
        ),
        GoRoute(
          path: '/dashboard/foods',
          builder: (context, state) => const FoodsView(),
        ),
        GoRoute(
          path: '/dashboard/meals',
          builder: (context, state) => const MealListView(),
        ),
        GoRoute(
          path: '/dashboard/ai',
          builder: (context, state) => const TipsView(),
        ),
        GoRoute(
          path: '/dashboard/fasting',
          builder: (context, state) => const FastingView(),
        ),
        GoRoute(
          path: '/dashboard/settings',
          builder: (context, state) => const SettingsView(),
        ),
      ],
    ),
  ],
);
