import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signIn/signInRepo.dart';
import 'package:get_it/get_it.dart';

void setupDependencies() {
  final authService = AuthService();
  final signInRepository = SignInRepository(authService);
  
  GetIt.instance.registerSingleton<AuthService>(authService);
  GetIt.instance.registerSingleton<SignInRepository>(signInRepository);
  
}