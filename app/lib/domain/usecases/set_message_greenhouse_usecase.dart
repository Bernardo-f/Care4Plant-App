import 'package:care4plant/domain/repositories/greenhouse_repository.dart';

class SetMessageGreenhouseUseCase {
  final GreenhouseRepository _repository;

  SetMessageGreenhouseUseCase(this._repository);

  Future<void> call() async {
    await _repository.setShowMessageGreenhouse();
  }
}
