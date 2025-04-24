import 'package:care4plant/domain/usecases/get_plant_usecase.dart';
import 'package:flutter/material.dart';

import '../../models/accesorio.dart';

class GetPlantProvider extends ChangeNotifier {
  final GetPlantUseCase getPlantUseCase;

  GetPlantProvider({required this.getPlantUseCase});

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  List<Accesorio>? _accesorios;
  List<Accesorio>? get accesorios => _accesorios;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPlantPicture() async {
    _loading = true;
    notifyListeners();

    try {
      _imageUrl = await getPlantUseCase.call();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
