import '../api/animal_api.dart';
import '../models/animal.dart';

class AnimalRepository {
  AnimalRepository({AnimalApi? api}) : _api = api ?? const AnimalApi();

  final AnimalApi _api;

  Future<List<Animal>> getAnimals() {
    return _api.fetchAnimals();
  }
}
