import 'package:care4plant/data/source/remote/stress_test_remote_data_source.dart';
import 'package:care4plant/domain/repositories/stress_test_repository.dart';
import 'package:care4plant/models/stress_test.dart';

class StressTestRepositoryImpl extends StressTestRepository {
  final StressTestRemoteDataSource stressTestApi;

  StressTestRepositoryImpl(this.stressTestApi);

  @override
  Future<dynamic> registerTest(Stresstest stressTest) async {
    try {
      return stressTestApi.registerTest(stressTest);
    } catch (e) {
      rethrow;
    }
  }
}
