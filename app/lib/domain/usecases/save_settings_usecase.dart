import 'package:care4plant/domain/repositories/user_repository.dart';

import '../../data/source/local/user_local_data_source.dart';
import '../../injection_container.dart';
import '../../models/user_settings.dart';

class SaveSettingsUseCase {
  final UserRepository _userRepository;

  SaveSettingsUseCase(this._userRepository);

  Future<void> call(UserSetting userSetting) async {
    try {
      final response = await _userRepository.saveSettings(userSetting);
      await sl<UserLocalDataSource>().saveSettings(userSetting);
      await sl<UserLocalDataSource>().savePlant(response);
    } catch (e) {
      rethrow;
    }
  }
}
