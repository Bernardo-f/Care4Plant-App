import '../../domain/repositories/greenhouse_repository.dart';
import '../../models/page_greenhouse.dart';
import '../../models/pensamiento.dart';
import '../source/local/greenhouse_local_data_source.dart';
import '../source/remote/greenhouse_remote_data_source.dart';

class GreenhouseRepositoryImpl extends GreenhouseRepository {
  final GreenhouseRemoteDataSource remoteDataSource;
  final GreenhouseLocalDataSource localDataSource;

  GreenhouseRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<bool> getShowMessageGreenhouse() {
    try {
      return localDataSource.getShowMessageGreenhouse();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setShowMessageGreenhouse() {
    try {
      return localDataSource.setShowMessageGreenhouse();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addPensamiento(Pensamiento pensamiento) {
    try {
      return remoteDataSource.addPensamiento(pensamiento);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Pensamiento>?> getPensamientos(String? email) {
    try {
      return remoteDataSource.getPensamientos(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> meGusta(String? emailEmisor, DateTime fechaPensamiento) {
    try {
      return remoteDataSource.meGusta(emailEmisor, fechaPensamiento);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PageGreenhouse> getUsers(int page) {
    try {
      return remoteDataSource.getUsers(page);
    } catch (e) {
      rethrow;
    }
  }
}
