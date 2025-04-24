import '../../domain/repositories/user_repository.dart';
import '../../models/accesorio.dart';
import '../../models/plant.dart';
import '../../models/recomendacion.dart';
import '../../models/user_settings.dart';
import '../source/local/user_local_data_source.dart';
import '../source/remote/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._userLocalDataSource);

  @override
  Future<Plant> saveSettings(UserSetting userSetting) async {
    try {
      final response = await _userRemoteDataSource.saveSettings(userSetting);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getName() async {
    try {
      final response = await _userLocalDataSource.getName();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getStressLevel() async {
    try {
      final response = await _userLocalDataSource.getStressLevel();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Accesorio>?> getAccesorios() async {
    try {
      final response = await _userRemoteDataSource.getAccesorios();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getPlantByStressLevel() async {
    try {
      final response = await _userLocalDataSource.getPlantByStressLevel();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> usarAccesorio(int idAccesorio) async {
    try {
      final response = await _userRemoteDataSource.usarAccesorio(idAccesorio);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setStressLevel(int stressLevel) async {
    try {
      await _userLocalDataSource.saveStressLevel(stressLevel);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getReporteDiario() async {
    try {
      final response = await _userLocalDataSource.getReporteDiario();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> validateDateTest() async {
    try {
      final response = await _userRemoteDataSource.validateDateTest();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Recomendacion>> getCategoriasRecomendadas() async {
    try {
      final response = await _userRemoteDataSource.getCategoriasRecomendadas();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getSemanaFrecuenciaTest() async {
    try {
      final response = await _userLocalDataSource.getSemanaFrecuenciaTest();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getFrecuenciaTest() async {
    try {
      final response = await _userLocalDataSource.getFrecuenciaTest();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> getAccesoInvernadero() async {
    try {
      final response = await _userLocalDataSource.getAccesoInvernadero();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> getNotificacionTest() async {
    try {
      final response = await _userLocalDataSource.getNotificacionTest();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> getNotificacionActividades() async {
    try {
      final response = await _userLocalDataSource.getNotificacionActividades();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _userLocalDataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setNotificacionTest(bool value) async {
    try {
      await _userRemoteDataSource.setNotificacionTest(value);
      await _userLocalDataSource.setNotificacionTest(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setNotificacionActividades(bool value) async {
    try {
      await _userRemoteDataSource.setNotificacionActividades(value);
      await _userLocalDataSource.setNotificacionActividades(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setAccesoInvernadero(bool value) async {
    try {
      await _userRemoteDataSource.setAccesoInvernadero(value);
      await _userLocalDataSource.setAccesoInvernadero(value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setFrecuenciaTest(int semanaFrecuenciaTest, int frecuenciaTest) async {
    try {
      await _userRemoteDataSource.setFrecuenciaTest(semanaFrecuenciaTest, frecuenciaTest);
      await _userLocalDataSource.setFrecuenciaTest(semanaFrecuenciaTest, frecuenciaTest);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
