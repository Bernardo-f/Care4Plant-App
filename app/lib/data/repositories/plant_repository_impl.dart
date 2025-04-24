import 'package:care4plant/data/source/remote/plant_remote_data_source.dart';
import 'package:care4plant/domain/repositories/plant_repository.dart';

import '../../models/plant.dart';

class PlantRepositoryImpl extends PlantRepository {
  final PlantRemoteDataSource _plantRemoteDataSource;

  PlantRepositoryImpl(this._plantRemoteDataSource);

  @override
  Future<List<Plant>> getAllPlants() async {
    try {
      final response = await _plantRemoteDataSource.getall();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
