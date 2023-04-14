import 'package:quiz_app/features/database/models/leaderboard_model.dart';
import 'package:quiz_app/features/database/models/score_model.dart';

import '../models/pokemon_model.dart';
import '../service/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<List<Pokemon>> getPokemonsList({int limit = 151}) async {
    List<Pokemon> pokemonList = await service.retrievePokemonList(limit);
    return pokemonList;
  }

  @override
  Future<Leaderboard> getLeaderboard({int limit = 10}) async {
    Leaderboard leaderboard = await service.retrieveLeaderboard(limit);
    return leaderboard;
  }
}

abstract class DatabaseRepository {
  Future<List<Pokemon>> getPokemonsList({int limit});
  Future<Leaderboard> getLeaderboard({int limit});
}
