class ValidateToken {
  final bool firstLogin;
  final bool firstStressLevelTest;

  ValidateToken({required this.firstLogin, required this.firstStressLevelTest});

  factory ValidateToken.fromMap(Map<String, dynamic> map) {
    return ValidateToken(
        firstLogin: map['firstLogin'], firstStressLevelTest: map['firstStressLevelTest']);
  }
}
