import 'package:care4plant/models/page_greenhouse.dart';

import '../repositories/greenhouse_repository.dart';

class GetUsuariosGreenhouseUseCase {
  final GreenhouseRepository _repository;

  GetUsuariosGreenhouseUseCase(this._repository);

  Future<PageGreenhouse> call(int page) async {
    return await _repository.getUsers(page);
  }
}
