import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/features/database/models/leaderboard_model.dart';
import 'package:quiz_app/features/database/models/pokemon_model.dart';
import 'package:quiz_app/features/database/models/score_model.dart';
import 'package:quiz_app/features/database/repository/database_repository.dart';
import 'package:quiz_app/features/database/service/database_service.dart';

void main() {
  late MockDatabaseService databaseService;
  late DatabaseRepositoryImpl databaseRepository;
  tearDown(() => {});

  setUp(() {
    databaseService = MockDatabaseService();
    databaseRepository = DatabaseRepositoryImpl(service: databaseService);
    databaseService.initPokemonsList();
    databaseService.initLeaderboard();
  });

  group('getPokemonsList', () {
    test('should return a list of pokemons', () async {
      int limit = 2;
      final result = await databaseRepository.getPokemonsList(limit: limit);
      final expected =
          generatePokemonListFromSnapshot(snapshot: mockPokemonListSnapshot);
      expect(result, isA<List<Pokemon>>());
      expect(result.length, limit);
      expect(expected, result);
    });
  });

  group('getLeaderbord', () {
    test('should return the leaderboard', () async {
      int limit = 2;
      final Leaderboard result =
          await databaseRepository.getLeaderboard(limit: limit);
      final expected =
          generateScoreListFromSnapshot(snapshot: mockScoresListSnapshot);
      expect(result, isA<Leaderboard>());
      expect(result.leaderboard.length, mockScoresListSnapshot.length);
      expect(expected, result);
    });
  });

  group('uploadScore', () {
    test('should upload the score', () async {
      final Score result =
          await databaseRepository.uploadScore(score: mockScoreToUpload);
      expect(result, isA<Score>());
      expect(result, mockScoreToUpload);
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
    },
    'type': 'grass',
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
    },
    'type': 'grass',
  }
];

final mockScoresListSnapshot = [
  {
    'name': 'user2',
    'score': 200,
    'timestamp': Timestamp.fromDate(DateTime.now()),
  },
  {
    'name': 'user1',
    'score': 100,
    'timestamp': Timestamp.fromDate(DateTime.now()),
  },
];

final mockScoreToUpload = Score(
  name: 'user3',
  score: 300,
  timestamp: DateTime.now(),
);

class MockDatabaseService extends Mock implements DatabaseService {
  late FakeFirebaseFirestore fakeFirebaseFirestore;

  MockDatabaseService({FakeFirebaseFirestore? fakeFirebaseFirestore})
      : fakeFirebaseFirestore =
            fakeFirebaseFirestore ?? FakeFirebaseFirestore();

  @override
  Future<QuerySnapshot<Map<String, dynamic>>?> retrievePokemonList(
      int listLenght) async {
    Future<QuerySnapshot<Map<String, dynamic>>?> pokemonsListSnapshot =
        fakeFirebaseFirestore
            .collection('pokemon')
            .orderBy('pokedex_id')
            .limit(listLenght)
            .get();
    return pokemonsListSnapshot;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>?> retrieveLeaderboard(
      int listLenght) {
    Future<QuerySnapshot<Map<String, dynamic>>?> leaderboardSnapshot =
        fakeFirebaseFirestore
            .collection('scores')
            .orderBy('score', descending: true)
            .limit(listLenght)
            .get();
    return leaderboardSnapshot;
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>?> uploadScore(Score score) {
    DocumentReference<Map<String, dynamic>> docRef =
        fakeFirebaseFirestore.collection('scores').doc();
    return docRef.set(score.toJson()).then((value) => docRef.get());
  }

  initPokemonsList() {
    WriteBatch batch = fakeFirebaseFirestore.batch();

    for (var pokemon in mockPokemonListSnapshot) {
      DocumentReference<Map<String, dynamic>> docRef =
          fakeFirebaseFirestore.collection('pokemon').doc();
      batch.set(docRef, pokemon);
    }
    batch.commit();
  }

  initLeaderboard() {
    WriteBatch batch = fakeFirebaseFirestore.batch();

    for (var score in mockScoresListSnapshot) {
      DocumentReference<Map<String, dynamic>> docRef =
          fakeFirebaseFirestore.collection('scores').doc();
      batch.set(docRef, score);
    }
    batch.commit();
  }
}

List<Pokemon> generatePokemonListFromSnapshot({required snapshot}) {
  List<Pokemon> pokemonsList = [];
  for (Map<dynamic, dynamic> pokemonSnapshot in mockPokemonListSnapshot) {
    pokemonsList.add(Pokemon(
        answers: pokemonSnapshot['answers'],
        name: pokemonSnapshot['name'],
        pokedexId: pokemonSnapshot['pokedex_id'],
        image: pokemonSnapshot['image'],
        type: PokemonType.fromJson(pokemonSnapshot['type'])));
  }

  return pokemonsList;
}

Leaderboard generateScoreListFromSnapshot({required snapshot}) {
  List<Score> scoresList = [];
  for (Map<dynamic, dynamic> scoreSnapshot in snapshot) {
    scoresList.add(Score(
        name: scoreSnapshot['name'],
        score: scoreSnapshot['score'],
        timestamp: (scoreSnapshot['timestamp'] as Timestamp).toDate()));
  }
  Leaderboard leaderboard = Leaderboard(leaderboard: scoresList);
  return leaderboard;
}
