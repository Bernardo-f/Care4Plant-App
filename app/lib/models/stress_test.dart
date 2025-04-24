import 'dart:convert';

class Stresstest {
  int? answer_1;
  int? answer_2;
  int? answer_3;
  int? answer_4;
  int? answer_5;
  int? answer_6;
  DateTime? fechaTest;

  Stresstest();

  //Se pasa el modelo a diccionario para poder transformalo a JSON
  Map<String, dynamic> toMap() {
    return {
      'Fecha_test': fechaTest!.toUtc().toIso8601String(),
      'Answer_1': answer_1,
      'Answer_2': answer_2,
      'Answer_3': answer_3,
      'Answer_4': answer_4,
      'Answer_5': answer_5,
      'Answer_6': answer_6
    };
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());

  void changeAnswer(index, value) {
    switch (index) {
      case 1:
        answer_1 = value;
        return;
      case 2:
        answer_2 = value;
        return;
      case 3:
        answer_3 = value;
        return;
      case 4:
        answer_4 = value;
        return;
      case 5:
        answer_5 = value;
        return;
      case 6:
        answer_6 = value;
        return;
      default:
        throw Exception("Invalid index");
    }
  }

  int? getAnswer(index) {
    switch (index) {
      case 1:
        return answer_1;
      case 2:
        return answer_2;
      case 3:
        return answer_3;
      case 4:
        return answer_4;
      case 5:
        return answer_5;
      case 6:
        return answer_6;
    }
    return null;
  }

  bool validate() {
    if (answer_1 == null ||
        answer_2 == null ||
        answer_3 == null ||
        answer_4 == null ||
        answer_5 == null ||
        answer_6 == null) {
      return false;
    }
    return true;
  }
}
