import 'package:care4plant/domain/repositories/greenhouse_repository.dart';

class GetMessageGreenhouseUseCase {
  final GreenhouseRepository _repository;

  GetMessageGreenhouseUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.getShowMessageGreenhouse();
  }
}
