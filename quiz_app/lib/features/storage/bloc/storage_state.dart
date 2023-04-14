part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitial extends StorageState {}

class StorageLoading extends StorageState {
  const StorageLoading({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

class StorageError extends StorageState {}

class StoragePokemonImageLoaded extends StorageState {
  const StoragePokemonImageLoaded({
    required this.pokemonImage,
  });

  final PokemonImage pokemonImage;

  @override
  List<Object> get props => [pokemonImage];
}
