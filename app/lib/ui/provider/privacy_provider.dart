import 'package:care4plant/domain/usecases/get_acceso_invernadero_usecase.dart';
import 'package:care4plant/domain/usecases/set_acceso_invernadero_usecase.dart';
import 'package:flutter/foundation.dart';

class PrivacyProvider extends ChangeNotifier {
  final GetAccesoInvernaderoUseCase getAccesoInvernaderoUseCase;
  final SetAccesoInvernaderoUseCase setAccesoInvernaderoUseCase;

  PrivacyProvider(
    this.getAccesoInvernaderoUseCase,
    this.setAccesoInvernaderoUseCase,
  );

  bool? _accesoInvernadero;
  bool? get accesoInvernadero => _accesoInvernadero;

  Future<void> init() async {
    _accesoInvernadero = await getAccesoInvernaderoUseCase.call();
    notifyListeners();
  }

  Future<void> setAccesoInvernadero(bool value) async {
    try {
      await setAccesoInvernaderoUseCase.call(value);
      _accesoInvernadero = value;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
