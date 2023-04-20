import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:quiz_app/exceptions/invalid_limit_exception.dart';
import 'package:quiz_app/exceptions/name_exception.dart';
import 'package:quiz_app/features/database/models/score_model.dart';
import 'package:quiz_app/features/database/service/database_service.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';
import 'package:quiz_app/constants/constants.dart' as constants;

void main() {
  tearDown(() {});

  group('retrievePokemonList', () {
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    late DatabaseService databaseService;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      databaseService = DatabaseService(firestore: fakeFirebaseFirestore);
    });
    test('should return a list of Pokemon', () async {
      const collectionPath = 'pokemon';
      int limit = 2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var pokemon in mockPokemonListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(collectionPath).doc();
        batch.set(docRef, pokemon);
      }
      batch.commit();

      final QuerySnapshot<Map<String, dynamic>> pokemonListSnapshot =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .orderBy('pokedex_id')
              .limit(limit)
              .get();

      final QuerySnapshot<Map<String, dynamic>>? pokemonListRetrievedSnapshot =
          await databaseService.retrievePokemonList(2);

      for (var i = 0; i < pokemonListSnapshot.docs.length; i++) {
        expect(
            const DeepCollectionEquality().equals(
                pokemonListSnapshot.docs[i].data(),
                pokemonListRetrievedSnapshot!.docs[i].data()),
            true);
      }
      expect(
          pokemonListRetrievedSnapshot!.docs.isSorted((a, b) =>
              a.data()['pokedex_id'].compareTo(b.data()['pokedex_id'])),
          true);
      expect(pokemonListSnapshot.docs.length,
          pokemonListRetrievedSnapshot.docs.length);
    });
    test('should return an empty list if no pokemon collection is found',
        () async {
      const wrongCollectionPath = 'pokemon2';
      int limit = 2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var pokemon in mockPokemonListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(wrongCollectionPath).doc();
        batch.set(docRef, pokemon);
      }
      batch.commit();

      final QuerySnapshot<Map<String, dynamic>>? pokemonListRetrievedSnapshot =
          await databaseService.retrievePokemonList(limit);

      expect(databaseService.retrievePokemonList(limit),
          isA<Future<QuerySnapshot<Map<String, dynamic>>?>>());
      expect(pokemonListRetrievedSnapshot!.docs.length, 0);
    });

    test('should return an exception if provided limit is negative', () async {
      const collectionPath = 'pokemon';
      int limit = -2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var pokemon in mockPokemonListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(collectionPath).doc();
        batch.set(docRef, pokemon);
      }
      batch.commit();

      expect(
          databaseService.retrievePokemonList(limit),
          throwsA(predicate((e) =>
              e is InvalidLimitValue &&
              e.limit == limit &&
              e.message == constants.INVALID_LIMIT_VALUE_ERROR)));
    });
  });

  group('retrieveLeaderboard', () {
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    late DatabaseService databaseService;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      databaseService = DatabaseService(firestore: fakeFirebaseFirestore);
    });
    test('should return a list of scores', () async {
      const collectionPath = 'scores';
      int limit = 2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var score in mockScoresListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(collectionPath).doc();
        batch.set(docRef, score);
      }
      batch.commit();

      final QuerySnapshot<Map<String, dynamic>> scoresListSnapshot =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .orderBy('score', descending: true)
              .limit(limit)
              .get();

      final QuerySnapshot<Map<String, dynamic>>? scoresListRetrievedSnapshot =
          await databaseService.retrieveLeaderboard(limit);

      for (var i = 0; i < scoresListSnapshot.docs.length; i++) {
        expect(
            const DeepCollectionEquality().equals(
                scoresListSnapshot.docs[i].data(),
                scoresListRetrievedSnapshot!.docs[i].data()),
            true);
      }
      expect(
          scoresListRetrievedSnapshot!.docs.isSorted(
              (a, b) => b.data()['score'].compareTo(a.data()['score'])),
          true);
      expect(scoresListSnapshot.docs.length,
          scoresListRetrievedSnapshot.docs.length);
    });
    test('should return an empty list if no scores collection is found',
        () async {
      const wrongCollectionPath = 'scores2';
      int limit = 2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var score in mockScoresListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(wrongCollectionPath).doc();
        batch.set(docRef, score);
      }
      batch.commit();

      final QuerySnapshot<Map<String, dynamic>>? scoresListRetrievedSnapshot =
          await databaseService.retrieveLeaderboard(limit);

      expect(databaseService.retrieveLeaderboard(limit),
          isA<Future<QuerySnapshot<Map<String, dynamic>>?>>());
      expect(scoresListRetrievedSnapshot!.docs.length, 0);
    });

    test('should return an exception if provided limit is negative', () async {
      const collectionPath = 'scores';
      int limit = -2;
      WriteBatch batch = fakeFirebaseFirestore.batch();

      for (var score in mockScoresListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(collectionPath).doc();
        batch.set(docRef, score);
      }
      batch.commit();

      expect(
          databaseService.retrieveLeaderboard(limit),
          throwsA(predicate((e) =>
              e is InvalidLimitValue &&
              e.limit == limit &&
              e.message == constants.INVALID_LIMIT_VALUE_ERROR)));
    });
  });

  group('uploadScore', () {
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    late DatabaseService databaseService;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      databaseService = DatabaseService(firestore: fakeFirebaseFirestore);
    });

    test('should upload a score', () async {
      const collectionPath = 'scores';

      DocumentSnapshot<Map<String, dynamic>>? scoreUpdated =
          await databaseService.uploadScore(mockScoreToUpload);

      QuerySnapshot<Map<String, dynamic>> scoreRetrievedFromFirestore =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .where('name', isEqualTo: mockScoreToUpload.name)
              .get();

      expect(scoreUpdated, isA<DocumentSnapshot<Map<String, dynamic>>>());
      expect(
          const DeepCollectionEquality()
              .equals(scoreUpdated!.data(), mockScoreToUpload.toJson()),
          true);
      expect(
          const DeepCollectionEquality().equals(
              scoreUpdated.data(), scoreRetrievedFromFirestore.docs[0].data()),
          true);
    });

    test(
        'should throw an exception if a score with the same name already existis',
        () async {
      const collectionPath = 'scores';

      await fakeFirebaseFirestore
          .collection(collectionPath)
          .add(mockScoreToUpload.toJson());

      expect(
          databaseService.uploadScore(mockScoreToUpload),
          throwsA(predicate((e) =>
              e is ScoreNameException &&
              e.name == mockScoreToUpload.name &&
              e.message == constants.SCORE_NAME_DUPLICATE_ERROR)));
    });
  });
}

final mockPokemonListSnapshot = [
  {
    'name': 'bulbasaur',
    'pokedex_id': 1,
    'image': 'gs://advmoapp-quizz-app.appspot.com/pokemon/1.png',
    'answers': {
      1: ['bulbasaur', true],
      2: ['ivysaur', false],
      3: ['venusaur', false],
      4: ['charmander', false],
    }
  },
  {
    'name': 'ivysaur',
    'pokedex_id': 2,
    'image': 'gs://advmoapp-quizz-app.appspot.com/pokemon/2.png',
    'answers': {
      1: ['bulbasaur', false],
      2: ['ivysaur', true],
      3: ['venusaur', false],
      4: ['charmander', false],
    }
  }
];

final mockScoresListSnapshot = [
  {
    'name': 'user1',
    'score': 100,
    'timestamp': Timestamp.fromDate(DateTime.now()),
  },
  {
    'name': 'user2',
    'score': 200,
    'timestamp': Timestamp.fromDate(DateTime.now()),
  }
];

final mockScoreToUpload = Score(
  name: 'user3',
  score: 300,
  timestamp: DateTime.now(),
);
