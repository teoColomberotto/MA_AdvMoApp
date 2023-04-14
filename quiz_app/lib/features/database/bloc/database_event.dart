part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class DatabaseGetPokemonsList extends DatabaseEvent {
  final int limit;

  const DatabaseGetPokemonsList({required this.limit});

  @override
  List<Object> get props => [limit];
}

class DatabaseGetPokemonImage extends DatabaseEvent {
  final PokemonImage imageData;

  const DatabaseGetPokemonImage({required this.imageData});

  @override
  List<Object> get props => [imageData];
}

class DatabaseGetLeaderboard extends DatabaseEvent {
  final int limit;

  const DatabaseGetLeaderboard({required this.limit});

  @override
  List<Object> get props => [limit];
}
