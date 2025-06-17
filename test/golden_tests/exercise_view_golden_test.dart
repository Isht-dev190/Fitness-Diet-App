import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_view.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_viewmodel.dart';
import 'package:app_dev_fitness_diet/frontend/features/exercises/exercise_repo.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class TestExerciseRepository implements ExerciseRepository {
  @override
  Future<Either<Failure, List<Exercise>>> getExercises() async {
    return Right([
      Exercise(
        name: 'Push-ups',
        category: 'strength',
        description: 'Basic push-up exercise',
        iconSvg: 'assets/helper svgs/strength.svg',
        videoUrl: 'https://example.com/video',
      ),
      Exercise(
        name: 'Squats',
        category: 'lower body',
        description: 'Basic squat exercise',
        iconSvg: 'assets/helper svgs/lowerbody.svg',
        videoUrl: 'https://example.com/video',
      ),
    ]);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestExerciseRepository testRepo;
  late ExerciseViewModel exerciseViewModel;
  late ThemeProvider themeProvider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
    testRepo = TestExerciseRepository();
    exerciseViewModel = ExerciseViewModel(testRepo);
    themeProvider = ThemeProvider();
  });

  testWidgets('Golden test for ExerciseView', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 600));

    // Create a widget to test
    Widget createTestWidget({required ThemeData theme}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
          ChangeNotifierProvider<ExerciseViewModel>.value(value: exerciseViewModel),
        ],
        child: MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ExerciseView(),
          ),
        ),
      );
    }

    // Test light mode
    await tester.pumpWidget(createTestWidget(theme: ThemeData.light()));
    await tester.pumpAndSettle(); // Wait for all animations and async operations

    await expectLater(
      find.byType(ExerciseView),
      matchesGoldenFile('goldens/exercise_view_light.png'),
    );

    // Test dark mode
    themeProvider.toggleTheme();
    await tester.pumpWidget(createTestWidget(theme: ThemeData.dark()));
    await tester.pumpAndSettle(); // Wait for all animations and async operations

    await expectLater(
      find.byType(ExerciseView),
      matchesGoldenFile('goldens/exercise_view_dark.png'),
    );
  });
} 