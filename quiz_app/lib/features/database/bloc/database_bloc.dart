import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/storage/bloc/storage_bloc.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../models/pokemon_model.dart';
import '../repository/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  final StorageBloc storageBloc;
  late final StreamSubscription storageSubscription;

  DatabaseBloc(this._databaseRepository, {required this.storageBloc})
      : super(DatabaseInitial()) {
    storageSubscription = storageBloc.stream.listen((storageState) {
      if (storageState is StoragePokemonImageLoaded) {
        add(DatabaseGetPokemonImage(
          imageData: storageState.pokemonImage,
        ));
      }
    });
    on<DatabaseEvent>((event, emit) async {
      if (event is DatabaseGetPokemonsList) {
        List<Pokemon> pokemonList = [];
        emit(const DatabaseLoading(message: 'Loading pokemons...'));

        try {
          pokemonList =
              await _databaseRepository.getPokemonsList(limit: event.limit);
          emit(DatabasePokemonsListLoaded(pokemons: pokemonList));
        } catch (e) {
          emit(DatabaseError());
        }

        for (var pokemon in pokemonList) {
          print("Downloading pokemon image: ${pokemon.pokedexId}");
          storageBloc
              .add(StorageDownloadPokemonImage(pokedexId: pokemon.pokedexId));
        }
      } else if (event is DatabaseGetPokemonImage) {
        emit(DatabasePokemonImageLoaded(imageData: event.imageData));
      }
    });
  }
}
