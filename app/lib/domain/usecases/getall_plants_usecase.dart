import '../repositories/plant_repository.dart';
import '../../models/plant.dart';

class GetAllPlantsUseCase {
  final PlantRepository repository;

  GetAllPlantsUseCase(this.repository);

  Future<List<Plant>> call() async {
    try {
      final response = await repository.getAllPlants();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
