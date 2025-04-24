import '../repositories/user_repository.dart';

class GetStressLevelUseCase {
  final UserRepository _userRepository;

  GetStressLevelUseCase(this._userRepository);

  Future<int> call() async {
    return await _userRepository.getStressLevel();
  }
}
