import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/database/models/leaderboard_model.dart';
import 'package:quiz_app/features/database/models/score_model.dart';

import '../models/pokemon_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Pokemon>> retrievePokemonList(int listLength) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection('pokemon')
        .orderBy('pokedex_id')
        .limit(listLength)
        .get()
        .catchError((e) => print("database service error: " + e));

    List<Pokemon> pokemonsList = snapshot.docs
        .map((docSnapshot) => Pokemon.fromDocumentSnapshot(docSnapshot))
        .toList();
    return pokemonsList;
  }

  Future<Leaderboard> retrieveLeaderboard(int limit) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(limit)
        .get()
        .catchError((e) => print("database service error: " + e));

    List<Score> scoreList = snapshot.docs
        .map((docSnapshot) => Score.fromDocumentSnapshot(docSnapshot))
        .toList();
    Leaderboard leaderboard = Leaderboard.fromScoreList(scoreList);
    return leaderboard;
  }
}
