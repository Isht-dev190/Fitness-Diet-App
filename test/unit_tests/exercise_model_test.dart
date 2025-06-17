import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';

void main() {
  group('Exercise Model Tests', () {
    test('Exercise instance creation', () {
      final exercise = Exercise(
        name: 'Push-ups',
        category: 'Strength',
        description: 'Basic push-up exercise',
        iconSvg: 'assets/icons/pushup.svg',
        videoUrl: 'https://example.com/pushup-video',
      );

      debugPrint('Exercise instance creation test');
      debugPrint('Name: ${exercise.name}, Category: ${exercise.category}');
      
      expect(exercise.name, equals('Push-ups'));
      expect(exercise.category, equals('Strength'));
      expect(exercise.description, equals('Basic push-up exercise'));
      expect(exercise.iconSvg, equals('assets/icons/pushup.svg'));
      expect(exercise.videoUrl, equals('https://example.com/pushup-video'));
    });

    test('Exercise.fromJson creates an Exercise instance correctly', () {
      final Map<String, dynamic> json = {
        'name': 'Squats',
        'category': 'Lower Body',
        'description': 'Basic squat exercise',
        'icon_svg': 'assets/icons/squat.svg',
        'video_url': 'https://example.com/squat-video'
      };

      final exercise = Exercise.fromJson(json);

      debugPrint('Exercise.fromJson test');
      debugPrint('Name: ${exercise.name}, Category: ${exercise.category}');

      expect(exercise.name, equals('Squats'));
      expect(exercise.category, equals('Lower Body'));
      expect(exercise.description, equals('Basic squat exercise'));
      expect(exercise.iconSvg, equals('assets/icons/squat.svg'));
      expect(exercise.videoUrl, equals('https://example.com/squat-video'));
    });

    test('Exercise.toJson converts instance to JSON correctly', () {
      final exercise = Exercise(
        name: 'Push-ups',
        category: 'Strength',
        description: 'Basic push-up exercise',
        iconSvg: 'assets/icons/pushup.svg',
        videoUrl: 'https://example.com/pushup-video',
      );

      final json = exercise.toJson();

      debugPrint('Exercise.toJson test');
      debugPrint('JSON: $json');

      expect(json['name'], equals('Push-ups'));
      expect(json['category'], equals('Strength'));
      expect(json['description'], equals('Basic push-up exercise'));
      expect(json['icon_svg'], equals('assets/icons/pushup.svg'));
      expect(json['video_url'], equals('https://example.com/pushup-video'));
    });

    test('Exercise.fromJson handles missing data', () {
      final Map<String, dynamic> incompleteJson = {
        'name': 'Incomplete Exercise',
        // Missing other fields
      };

      debugPrint('Exercise.fromJson incomplete data test');
      final exercise = Exercise.fromJson(incompleteJson);

      expect(exercise.name, equals('Incomplete Exercise'));
      expect(exercise.category, equals(''));
      expect(exercise.description, equals(''));
      expect(exercise.iconSvg, equals(''));
      expect(exercise.videoUrl, equals(''));
    });

    test('Exercise.fromJson handles null values', () {
      final Map<String, dynamic> nullJson = {
        'name': null,
        'category': null,
        'description': null,
        'icon_svg': null,
        'video_url': null
      };

      debugPrint('Exercise.fromJson null data test');
      final exercise = Exercise.fromJson(nullJson);

      expect(exercise.name, equals(''));
      expect(exercise.category, equals(''));
      expect(exercise.description, equals(''));
      expect(exercise.iconSvg, equals(''));
      expect(exercise.videoUrl, equals(''));
    });
  });
} 