
class ValidateFunctions {

   static bool isValidAge(String age) {
    // First check if it's a number
    if (int.tryParse(age) == null) return false;
    
    // Then check if it's in valid range
    int ageValue = int.parse(age);
    return ageValue >= 5 && ageValue <= 120;
  }

  static bool isValidEmail(String email) {
    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return email.isNotEmpty && emailRegex.hasMatch(email);
  }
  
  static bool isValidPassword(String password) {
    // Password validation (at least 8 characters)
    return password.isNotEmpty && password.length >= 8;
  }

    }


