import '../../models/categoria.dart';
import '../repositories/categoria_repository.dart';

class GetCategoriasUseCase {
  final CategoriaRepository _repository;

  GetCategoriasUseCase(this._repository);

  Future<List<Categoria>?> call() async {
    return await _repository.getAll();
  }
}
