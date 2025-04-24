import 'package:care4plant/domain/repositories/user_repository.dart';

import '../../injection_container.dart';

class UsarAccesorioUseCase {
  final UserRepository _userRepository;

  UsarAccesorioUseCase(this._userRepository);

  Future<void> call(int idAccesorio) async {
    try {
      final stressLevel = await _userRepository.usarAccesorio(idAccesorio);
      sl<UserRepository>().setStressLevel(stressLevel);
    } catch (e) {
      rethrow;
    }
  }
}
