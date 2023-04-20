import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:quiz_app/exceptions/pokemon_image_notfound.dart';
import 'package:quiz_app/features/storage/service/storage_service.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';
import 'package:quiz_app/constants/constants.dart' as constants;

void main() {
  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
  tearDown(() => {});

  group('downloadPokemonImage', () {
    late MockFirebaseStorage fakeFirebaseStorage;
    late StorageService storageService;
    setUp(() => {
          fakeFirebaseStorage = MockFirebaseStorage(),
          storageService = StorageService(storage: fakeFirebaseStorage),
        });

    test('should return a Uint8List', () async {
      const pokedexId = 1;
      final defaultImage = await loadDefaultImage();
      final ref = fakeFirebaseStorage.ref().child("pokemon/$pokedexId.png");
      ref.putData(defaultImage!);

      final result = await storageService.downloadPokemonImage(pokedexId);

      expect(result, isA<Uint8List>());
      expect(result, defaultImage);
      expect(const ListEquality().equals(result, defaultImage), true);
    });

    test('should return null if the image does not exist', () async {
      const pokedexId = 1;
      expect(
          storageService.downloadPokemonImage(pokedexId),
          throwsA(predicate((e) =>
              e is PokemonImageNotFound &&
              e.pokedexId == pokedexId &&
              e.message == constants.POKEMON_IMAGE_NOT_FOUND_ERROR)));
    });
  });
}

//load default image from assets into a uint8list
Future<Uint8List?> loadDefaultImage() async {
  final ByteData data =
      await rootBundle.load('assets/images/defaultPokemonImage.png');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
