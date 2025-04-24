import 'package:care4plant/domain/usecases/save_settings_usecase.dart';
import 'package:care4plant/models/user_settings.dart';
import 'package:flutter/widgets.dart';

enum SaveSettingsState { idle, loading, loaded, error }

class SaveSettingsProvider extends ChangeNotifier {
  final SaveSettingsUseCase saveSettingsUseCase;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  SaveSettingsProvider({required this.saveSettingsUseCase});

  SaveSettingsState _state = SaveSettingsState.idle;

  SaveSettingsState get state => _state;

  void setState(SaveSettingsState state) {
    _state = state;
    notifyListeners();
  }

  void saveSettings(UserSetting userSetting) async {
    setState(SaveSettingsState.loading);
    try {
      await saveSettingsUseCase.call(userSetting);
      setState(SaveSettingsState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      setState(SaveSettingsState.error);
    }
  }

  void resetState() {
    _state = SaveSettingsState.idle;
    notifyListeners();
  }
}
