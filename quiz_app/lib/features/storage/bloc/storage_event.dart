part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => [];
}

class StorageDownloadPokemonImage extends StorageEvent {
  const StorageDownloadPokemonImage({
    required this.pokedexId,
  });

  final int pokedexId;

  @override
  List<Object> get props => [pokedexId];
}
