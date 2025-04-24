import 'package:care4plant/data/source/local/user_local_data_source.dart';
import 'package:care4plant/domain/repositories/stress_test_repository.dart';

import '../../injection_container.dart';
import '../../models/stress_test.dart';

class RegisterStressTestUseCase {
  final StressTestRepository _stressTestRepository;

  RegisterStressTestUseCase(this._stressTestRepository);

  Future<dynamic> call(Stresstest stressTest) async {
    try {
      final response = await _stressTestRepository.registerTest(stressTest);
      sl<UserLocalDataSource>().saveStressLevel(int.parse(response));
    } catch (e) {
      rethrow;
    }
  }
}
