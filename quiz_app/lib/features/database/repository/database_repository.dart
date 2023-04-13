import '../models/pokemon_model.dart';
import '../service/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<List<Pokemon>> getPokemonsList({int limit = 151}) async {
    List<Pokemon> pokemonList = await service.retrievePokemonList(limit);
    return pokemonList;
  }
}

abstract class DatabaseRepository {
  Future<List<Pokemon>> getPokemonsList({int limit});
}
