import 'package:care4plant/domain/usecases/get_notificacion_actividades_usecase.dart';
import 'package:care4plant/domain/usecases/set_notificacion_actividades_usecase.dart';
import 'package:care4plant/domain/usecases/set_notificacion_test_usecase.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_notificacion_test_usecase.dart';

class NotificacionesProvider extends ChangeNotifier {
  final GetNotificacionActividadesUseCase getNotificacionActividadesUseCase;
  final GetNotificacionTestUseCase getNotificacionTestUseCase;
  final SetNotificacionActividadesUseCase setNotificacionActividadesUseCase;
  final SetNotificacionTestUseCase setNotificacionTestUseCase;

  NotificacionesProvider(
    this.getNotificacionActividadesUseCase,
    this.getNotificacionTestUseCase,
    this.setNotificacionActividadesUseCase,
    this.setNotificacionTestUseCase,
  );

  bool? _notificacionActividades;
  bool? _notificacionTest;

  bool? get notificacionActividades => _notificacionActividades;
  bool? get notificacionTest => _notificacionTest;

  Future<void> init() async {
    _notificacionActividades = await getNotificacionActividadesUseCase.call();
    _notificacionTest = await getNotificacionTestUseCase.call();
    notifyListeners();
  }

  Future<void> setNotificacionActividades(bool value) async {
    try {
      await setNotificacionActividadesUseCase.call(value);
      _notificacionActividades = value;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setNotificacionTest(bool value) async {
    try {
      await setNotificacionTestUseCase.call(value);
      _notificacionTest = value;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
