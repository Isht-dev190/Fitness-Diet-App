
 class RegisterCubitState {

  final String age;
  final String gender;
  final String lifestyle;
  final int height;
  final int weight;
  final String email;
  final String password;

  RegisterCubitState({
    this.age = '',
    this.gender = '',
    this.lifestyle = '',
    this.height = 0,
    this.weight = 0,
    this.email = '',
    this.password = '',
   
  });

  RegisterCubitState copyWith({
    String? age,
    String? gender,
    String? lifestyle,
    int? height,
    int? weight,
    String? email,
    String? password,
  }) {
    return RegisterCubitState(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      lifestyle: lifestyle ?? this.lifestyle,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}



