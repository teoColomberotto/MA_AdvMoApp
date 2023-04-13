import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/pokemon_model.dart';
import '../repository/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) async {
      if (event is DatabaseGetPokemonsList) {
        emit(const DatabaseLoading(message: 'Loading pokemons...'));

        try {
          List<Pokemon> pokemonList =
              await _databaseRepository.getPokemonsList(limit: event.limit);
          emit(DatabasePokemonsListLoaded(pokemons: pokemonList));
        } catch (e) {
          emit(DatabaseError());
        }
      }
    });
  }
}
