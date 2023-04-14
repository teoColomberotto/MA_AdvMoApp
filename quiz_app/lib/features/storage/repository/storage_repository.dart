import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../service/storage_service.dart';

class StorageRepositoryImpl implements StorageRepository {
  StorageService service = StorageService();

  @override
  Future<PokemonImage> downloadPokemonImage({required int pokedexId}) async {
    final PokemonImage pokemonImage =
        await service.downloadPokemonImage(pokedexId);
    return pokemonImage;
  }
}

abstract class StorageRepository {
  Future<PokemonImage> downloadPokemonImage({required int pokedexId});
}
