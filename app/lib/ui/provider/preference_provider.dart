import 'package:care4plant/domain/usecases/get_frecuencia_test_usecase.dart';
import 'package:care4plant/domain/usecases/get_semana_frecuencia_test_usecase.dart';
import 'package:care4plant/domain/usecases/set_frecuencia_test_usecase.dart';
import 'package:flutter/foundation.dart';

class PreferenceProvider extends ChangeNotifier {
  final GetSemanaFrecuenciaTestUseCase getSemanaFrecuenciaTestUseCase;
  final GetFrecuenciaTestUseCase getFrecuenciaTestUseCase;
  final SetFrecuenciaTestUseCase setFrecuenciaTestUseCase;

  PreferenceProvider(
    this.getSemanaFrecuenciaTestUseCase,
    this.getFrecuenciaTestUseCase,
    this.setFrecuenciaTestUseCase,
  );

  int? _semanaFrecuenciaTest;
  int? _frecuenciaTest;

  int? get semanaFrecuenciaTest => _semanaFrecuenciaTest;
  int? get frecuenciaTest => _frecuenciaTest;

  Future<void> init() async {
    _semanaFrecuenciaTest = await getSemanaFrecuenciaTestUseCase.call();
    _frecuenciaTest = await getFrecuenciaTestUseCase.call();
    notifyListeners();
  }

  dynamic setFrecuenciaTest(bool value, int semanaFrecuenciaTest, int frecuenciaTest) async {
    if (!value) {
      return;
    }
    try {
      _semanaFrecuenciaTest = semanaFrecuenciaTest;
      _frecuenciaTest = frecuenciaTest;
      await setFrecuenciaTestUseCase.call(semanaFrecuenciaTest, frecuenciaTest);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
