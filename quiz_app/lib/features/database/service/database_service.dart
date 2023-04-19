import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/features/database/models/leaderboard_model.dart';
import 'package:quiz_app/features/database/models/score_model.dart';

import '../../../exceptions/name_exception.dart';
import '../models/pokemon_model.dart';

class DatabaseService {
  final FirebaseFirestore firestore;

  DatabaseService({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Pokemon>> retrievePokemonList(int listLength) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('pokemon')
        .orderBy('pokedex_id')
        .limit(listLength)
        .get()
        .catchError((e) => debugPrint("database service error: $e"));

    List<Pokemon> pokemonsList = snapshot.docs
        .map((docSnapshot) => Pokemon.fromDocumentSnapshot(docSnapshot))
        .toList();
    return pokemonsList;
  }

  Future<Leaderboard> retrieveLeaderboard(int limit) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(limit)
        .get()
        .catchError((e) => debugPrint("database service error: $e"));

    List<Score> scoreList = snapshot.docs
        .map((docSnapshot) => Score.fromDocumentSnapshot(docSnapshot))
        .toList();
    Leaderboard leaderboard = Leaderboard.fromScoreList(scoreList);
    return leaderboard;
  }

  Future<Score> uploadScore(Score score) async {
    //search if a score with the same name already exsists in collection scores
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('scores')
        .where('name', isEqualTo: score.name)
        .get()
        .catchError((e) => debugPrint("database service error: $e"));

    if (snapshot.docs.isNotEmpty) {
      throw ScoreNameException(name: score.name);
    }

    DocumentReference<Map<String, dynamic>> docRef = await firestore
        .collection('scores')
        .add(score.toJson())
        .catchError((e) => debugPrint("database service error: $e"));

    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef
        .get()
        .catchError((e) => debugPrint("database service error: $e"));

    Score scoreFromDb = Score.fromDocumentSnapshot(docSnapshot);
    return scoreFromDb;
  }
}
