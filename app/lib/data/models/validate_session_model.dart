import 'dart:convert';

class ValidateSessionModel {
  final bool firstLogin;
  final bool firstStressLevelTest;

  ValidateSessionModel({required this.firstLogin, required this.firstStressLevelTest});

  factory ValidateSessionModel.fromMap(Map<String, dynamic> map) {
    return ValidateSessionModel(
        firstLogin: map['firstLogin'] ?? false,
        firstStressLevelTest: map['firstStressLevelTest'] ?? false);
  }

  factory ValidateSessionModel.fromJson(String source) =>
      ValidateSessionModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'firstLogin': firstLogin,
      'firstStressLevelTest': firstStressLevelTest,
    };
  }
}
