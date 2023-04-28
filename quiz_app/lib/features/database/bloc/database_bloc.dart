import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/exceptions/name_exception.dart';
import 'package:quiz_app/features/storage/bloc/storage_bloc.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../models/leaderboard_model.dart';
import '../models/pokemon_model.dart';
import '../models/score_model.dart';
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
          emit(DatabaseError(message: e.toString()));
        }
      } else if (event is DatabaseGetPokemonImage) {
        emit(DatabasePokemonImageLoaded(imageData: event.imageData));
      } else if (event is DatabaseGetLeaderboard) {
        emit(const DatabaseLoading(message: 'Loading leaderboard...'));

        try {
          Leaderboard leaderboard =
              await _databaseRepository.getLeaderboard(limit: event.limit);
          emit(DatabaseLeaderboardLoaded(leaderboard: leaderboard));
        } catch (e) {
          emit(DatabaseError(message: e.toString()));
        }
      } else if (event is DatabaseAddScore) {
        emit(const DatabaseLoading(message: 'Uploading score...'));

        try {
          Score score =
              await _databaseRepository.uploadScore(score: event.score);
          emit(DatabaseScoreAdded(score: score));
        } on ScoreNameException {
          // todo - handle better excpetion by using internal name variable
          emit(DatabaseScoreNameAlreadyExists(name: event.score.name));
        } catch (e) {
          debugPrint("Error: $e");
          emit(DatabaseError(message: e.toString()));
        }
      }
    });
  }

  @override
  Future<void> close() {
    storageSubscription.cancel();
    return super.close();
  }
}
