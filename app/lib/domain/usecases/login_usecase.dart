import 'package:care4plant/core/services/storage/secure_storage_service.dart';
import 'package:care4plant/data/source/local/user_local_data_source.dart';
import 'package:care4plant/domain/repositories/auth_repository.dart';
import 'package:care4plant/models/plant.dart';
import 'package:care4plant/models/user_info.dart';
import 'package:care4plant/injection_container.dart';

class LoginUseCase {
  final AuthRepository _userRepository;

  LoginUseCase(this._userRepository);

  Future<dynamic> call(String email, String password) async {
    try {
      final response = await _userRepository.login(email, password);

      await SecureStorageService().saveToken(response['token']);
      await sl<UserLocalDataSource>().saveInfo(UserInfo.fromJson(response['user']));
      if (response['plant'] != null) {
        await sl<UserLocalDataSource>().savePlant(Plant.fromJson(response['plant']));
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
