import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';
import 'package:quiz_app/features/storage/repository/storage_repository.dart';
import 'package:quiz_app/features/storage/service/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockStorageService storageService;
  late StorageRepositoryImpl storageRepository;
  setUp(() {
    storageService = MockStorageService();
    storageRepository = StorageRepositoryImpl(service: storageService);
  });
  tearDown(() => {});

  group('downloadPokemonImage', () {
    test('should return a pokemon image', () async {
      const pokedexId = 1;
      final result =
          await storageRepository.downloadPokemonImage(pokedexId: pokedexId);
      expect(result, isA<PokemonImage>());
    });
  });
}

class MockStorageService extends Mock implements StorageService {
  @override
  Future<Uint8List>? downloadPokemonImage(int pokedexId) async {
    final ByteData data =
        await rootBundle.load('assets/images/defaultPokemonImage.png');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
