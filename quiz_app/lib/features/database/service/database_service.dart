import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/database/models/score_model.dart';

import '../../../exceptions/name_exception.dart';

class DatabaseService {
  final FirebaseFirestore firestore;

  DatabaseService({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>?> retrievePokemonList(
      int listLength) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('pokemon')
        .orderBy('pokedex_id')
        .limit(listLength)
        .get()
        .catchError((e) => e);

    return snapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> retrieveLeaderboard(
      int limit) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(limit)
        .get()
        .catchError((e) => e);

    return snapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> uploadScore(
      Score score) async {
    DocumentReference<Map<String, dynamic>> docRef =
        await firestore.runTransaction((transaction) async {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('scores')
          .where('name', isEqualTo: score.name)
          .get()
          .catchError((e) => e);

      if (snapshot.docs.isNotEmpty) {
        throw ScoreNameException(name: score.name);
      } else {
        return await firestore
            .collection('scores')
            .add(score.toJson())
            .catchError((e) => e);
      }
    });
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get().catchError((e) => e);
    return docSnapshot;
  }
}
