import 'package:care4plant/domain/repositories/user_repository.dart';

class GetNameUseCase {
  final UserRepository _userRepository;

  GetNameUseCase(this._userRepository);

  Future<String> call() async {
    return _userRepository.getName();
  }
}
