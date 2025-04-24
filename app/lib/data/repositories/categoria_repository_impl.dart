import 'package:care4plant/data/source/remote/categoria_remote_data_source.dart';

import '../../domain/repositories/categoria_repository.dart';
import '../../models/categoria.dart';

class CategoriaRepositoryImpl extends CategoriaRepository {
  final CategoriaRemoteDataSource remoteDataSource;

  CategoriaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Categoria>?> getAll() async {
    try {
      final result = await remoteDataSource.getAll('es');
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
