import 'package:app_dev_fitness_diet/frontend/core/Exceptions/failure.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/user_storage_service.dart';
import 'package:app_dev_fitness_diet/frontend/core/secrets/hive_storage_service.dart';
import 'package:fpdart/fpdart.dart';

class RegUserRepository {
  final AuthService _authService;
  final _userStorage = UserStorageService();
  final _sessionStorage = HiveStorageService();

  RegUserRepository(this._authService);

  Future<Either<Failure, String>> RegisterUser(UserModel user) async {
    try {
      // First store user data in Hive
      await _userStorage.saveUser(user);

      // Then try to register with Supabase
      final success = await _authService.signUp(user);
      
      if (success) {
        return const Right("Registration Successful");
      } else {
        // If Supabase registration fails, clean up Hive data
        await _userStorage.deleteUser(user.email);
        return Left(Failure("Registration Failed"));
      }
    } catch (e) {
      // Clean up any partial registrations
      try {
        await _userStorage.deleteUser(user.email);
        await _sessionStorage.clearUserSession();
      } catch (_) {
        // Ignore cleanup errors
      }
      return Left(Failure(e.toString()));
    }
  }
}