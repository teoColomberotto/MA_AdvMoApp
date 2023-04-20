import '../constants/constants.dart' as constants;

class PokemonImageNotFound implements Exception {
  final int pokedexId;
  final String message;

  PokemonImageNotFound(
      {required this.pokedexId,
      this.message = constants.POKEMON_IMAGE_NOT_FOUND_ERROR});

  @override
  String toString() => message;
}
