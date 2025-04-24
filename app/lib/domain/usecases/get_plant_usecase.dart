import 'package:care4plant/data/source/local/user_local_data_source.dart';

import '../../injection_container.dart';

class GetPlantUseCase {
  Future<String?> call() async {
    return await sl<UserLocalDataSource>().getPlantByStressLevel();
  }
}
