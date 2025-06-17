import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('UserModel instance creation', () {
      final user = UserModel(
        email: 'test@example.com',
        password: 'password123',
        age: '25',
        gender: 'male',
        height: 175,
        weight: 70,
        lifestyle: 'active',
        bmi: 23,
        tdee: 2500,
      );

      debugPrint('UserModel instance creation test');
      debugPrint('Email: ${user.email}, Age: ${user.age}, Gender: ${user.gender}');
      
      expect(user.email, equals('test@example.com'));
      expect(user.password, equals('password123'));
      expect(user.age, equals('25'));
      expect(user.gender, equals('male'));
      expect(user.height, equals(175));
      expect(user.weight, equals(70));
      expect(user.lifestyle, equals('active'));
      expect(user.bmi, equals(23));
      expect(user.tdee, equals(2500));
    });

    test('UserModel.fromJson creates a UserModel instance correctly', () {
      final Map<String, dynamic> json = {
        'email': 'json@example.com',
        'password': 'jsonpass123',
        'age': '30',
        'gender': 'female',
        'height': '165',
        'weight': '60',
        'lifestyle': 'sedentary',
        'bmi': '22',
        'tdee': '2000'
      };

      final user = UserModel.fromJson(json);

      debugPrint('UserModel.fromJson test');
      debugPrint('Email: ${user.email}, Age: ${user.age}, Gender: ${user.gender}');

      expect(user.email, equals('json@example.com'));
      expect(user.password, equals('jsonpass123'));
      expect(user.age, equals('30'));
      expect(user.gender, equals('female'));
      expect(user.height, equals(165));
      expect(user.weight, equals(60));
      expect(user.lifestyle, equals('sedentary'));
      expect(user.bmi, equals(22));
      expect(user.tdee, equals(2000));
    });

    test('UserModel.toJson converts instance to JSON correctly', () {
      final user = UserModel(
        email: 'test@example.com',
        password: 'password123',
        age: '25',
        gender: 'male',
        height: 175,
        weight: 70,
        lifestyle: 'active',
        bmi: 23,
        tdee: 2500,
      );

      final json = user.toJson();

      debugPrint('UserModel.toJson test');
      debugPrint('JSON: $json');

      expect(json['email'], equals('test@example.com'));
      expect(json['password'], equals('password123'));
      expect(json['age'], equals('25'));
      expect(json['gender'], equals('male'));
      expect(json['height'], equals(175));
      expect(json['weight'], equals(70));
      expect(json['lifestyle'], equals('active'));
      expect(json['bmi'], equals(23));
      expect(json['tdee'], equals(2500));
    });

    test('UserModel.fromJson handles missing or invalid data', () {
      final Map<String, dynamic> incompleteJson = {
        'email': 'incomplete@example.com',
        // Missing other fields
      };

      debugPrint('UserModel.fromJson incomplete data test');
      final user = UserModel.fromJson(incompleteJson);

      expect(user.email, equals('incomplete@example.com'));
      expect(user.password, equals(''));
      expect(user.age, equals(''));
      expect(user.gender, equals(''));
      expect(user.height, equals(0));
      expect(user.weight, equals(0));
      expect(user.lifestyle, equals(''));
      expect(user.bmi, equals(0));
      expect(user.tdee, equals(0));
    });

    test('UserModel.fromJson handles invalid numeric values', () {
      final Map<String, dynamic> invalidJson = {
        'email': 'invalid@example.com',
        'height': 'not a number',
        'weight': 'invalid',
        'bmi': 'wrong',
        'tdee': 'incorrect'
      };

      debugPrint('UserModel.fromJson invalid numeric data test');
      final user = UserModel.fromJson(invalidJson);

      expect(user.email, equals('invalid@example.com'));
      expect(user.height, equals(0));
      expect(user.weight, equals(0));
      expect(user.bmi, equals(0));
      expect(user.tdee, equals(0));
    });
  });
} 