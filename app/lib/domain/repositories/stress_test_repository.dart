import 'package:care4plant/models/stress_test.dart';

abstract class StressTestRepository {
  Future<dynamic> registerTest(Stresstest stressTest);
}
