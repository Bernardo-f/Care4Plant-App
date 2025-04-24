import '../../models/accesorio.dart';
import '../repositories/user_repository.dart';

class GetAccesoriosUseCase {
  final UserRepository _userRepository;

  GetAccesoriosUseCase(this._userRepository);

  Future<List<Accesorio>?> call() async {
    return await _userRepository.getAccesorios();
  }
}
