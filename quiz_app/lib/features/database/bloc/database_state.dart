part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoading extends DatabaseState {
  final String message;

  const DatabaseLoading({required this.message});

  @override
  List<Object> get props => [message];
}

class DatabaseError extends DatabaseState {
  final String message;

  const DatabaseError({required this.message});

  @override
  List<Object> get props => [];
}

class DatabasePokemonsListLoaded extends DatabaseState {
  final List<Pokemon> pokemons;

  const DatabasePokemonsListLoaded({required this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class DatabasePokemonImageLoaded extends DatabaseState {
  final PokemonImage imageData;

  const DatabasePokemonImageLoaded({required this.imageData});

  @override
  List<Object> get props => [imageData];
}

class DatabaseLeaderboardLoaded extends DatabaseState {
  final Leaderboard leaderboard;

  const DatabaseLeaderboardLoaded({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}
