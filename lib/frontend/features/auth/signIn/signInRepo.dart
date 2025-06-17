import 'package:app_dev_fitness_diet/frontend/core/Exceptions/failure.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:fpdart/fpdart.dart';

class SignInRepository {
  final AuthService _authService;
  SignInRepository(this._authService);

  Future<Either<Failure, String>> signInUser(String email, String password) async {
    try {
      final result = await _authService.signIn(email, password);
      if(result) {
        return const Right("Login Successful");
      } else {
        return Left(Failure(_authService.error ?? "Login Failed"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      final result = await _authService.signInWithGoogle();
      if(result) {
        return const Right("Google Login Successful");
      } else {
        return Left(Failure(_authService.error ?? "Google Login Failed"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

