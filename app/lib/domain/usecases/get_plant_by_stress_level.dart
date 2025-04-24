import 'package:care4plant/domain/repositories/user_repository.dart';

class GetPlantByStressLevelUseCase {
  final UserRepository _userRepository;

  GetPlantByStressLevelUseCase(this._userRepository);

  Future<String?> call() async {
    return await _userRepository.getPlantByStressLevel();
  }
}
