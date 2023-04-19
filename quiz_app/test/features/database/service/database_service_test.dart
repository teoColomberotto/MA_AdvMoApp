import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:quiz_app/features/database/models/pokemon_model.dart';
import 'package:quiz_app/features/database/service/database_service.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

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

      //insert mock data in fake firestore
      for (var pokemon in mockPokemonListSnapshot) {
        DocumentReference<Map<String, dynamic>> docRef =
            fakeFirebaseFirestore.collection(collectionPath).doc();
        batch.set(docRef, pokemon);
      }
      batch.commit();

      //retrieve mock data from fake firestore
      final QuerySnapshot<Map<String, dynamic>> pokemonListSnapshot =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .orderBy('pokedex_id')
              .limit(limit)
              .get();
      final List<Pokemon> pokemonsList = pokemonListSnapshot.docs
          .map((docSnapshot) => Pokemon.fromDocumentSnapshot(docSnapshot))
          .toList();

      // Create a new List<Pokemon> from the retrieved data
      final List<Pokemon> pokemonListRetrieved =
          await databaseService.retrievePokemonList(2);

      // Compare the actual data with the retrieved data
      expect(pokemonListRetrieved.runtimeType, List<Pokemon>);
      expect(pokemonListRetrieved, pokemonsList);
      expect(pokemonListRetrieved.length, limit);
      expect(
          pokemonListRetrieved
              .isSorted((a, b) => a.pokedexId.compareTo(b.pokedexId)),
          true);
    });
  });
}

const mockPokemonListSnapshot = [
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
