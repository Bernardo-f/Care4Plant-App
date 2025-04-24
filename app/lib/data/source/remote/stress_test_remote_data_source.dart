import '../../../core/error/server_exception.dart';
import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/stress_test.dart';

class StressTestRemoteDataSource {
  // Simulate a network delay
  final CustomHttpClient client;
  StressTestRemoteDataSource(this.client);

  Future<dynamic> registerTest(Stresstest stressTest) async {
    try {
      final response = await client.post(
        '$apiUrl/api/stresstest/Register', // Replace with your API endpoint
        body: stressTest.toMap(), // Convert your object to a map or JSON string
      );
      if (response.statusCode == 200) {
        return response.body; // Handle the response as needed
      } else {
        throw ServerException(response.body); // Handle error response
      }
    } catch (e) {
      rethrow; // Handle any exceptions that may occur
    }
  }
}
