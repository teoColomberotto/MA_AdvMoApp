import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/database/models/leaderboard_model.dart';
import 'package:quiz_app/features/database/models/score_model.dart';

import '../models/pokemon_model.dart';
import '../service/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService service;

  DatabaseRepositoryImpl({DatabaseService? service})
      : service = service ?? DatabaseService();

  @override
  Future<List<Pokemon>> getPokemonsList({int limit = 151}) async {
    QuerySnapshot<Map<String, dynamic>>? pokemonsListSnapshot =
        await service.retrievePokemonList(limit);

    List<Pokemon> pokemonsList = pokemonsListSnapshot!.docs
        .map((docSnapshot) => Pokemon.fromDocumentSnapshot(docSnapshot))
        .toList();
    pokemonsList.shuffle();
    return pokemonsList;
  }

  @override
  Future<Leaderboard> getLeaderboard({int limit = 10}) async {
    QuerySnapshot<Map<String, dynamic>>? leaderboardSnapshot =
        await service.retrieveLeaderboard(limit);

    List<Score> scoreList = leaderboardSnapshot!.docs
        .map((docSnapshot) => Score.fromDocumentSnapshot(docSnapshot))
        .toList();
    Leaderboard leaderboard = Leaderboard.fromScoreList(scoreList);
    return leaderboard;
  }

  @override
  Future<Score> uploadScore({required Score score}) async {
    DocumentSnapshot<Map<String, dynamic>>? scoreSnapshot =
        await service.uploadScore(score);

    Score scoreFromDb = Score.fromDocumentSnapshot(scoreSnapshot!);
    return scoreFromDb;
  }
}

abstract class DatabaseRepository {
  Future<List<Pokemon>> getPokemonsList({int limit});
  Future<Leaderboard> getLeaderboard({int limit});
  Future<Score> uploadScore({required Score score});
}
