class ValidateSessionEntity {
  final bool firstLogin;
  final bool firstStressLevelTest;

  ValidateSessionEntity({required this.firstLogin, required this.firstStressLevelTest});

  factory ValidateSessionEntity.fromMap(Map<String, dynamic> map) {
    return ValidateSessionEntity(
        firstLogin: map['firstLogin'] ?? false,
        firstStressLevelTest: map['firstStressLevelTest'] ?? false);
  }
}
