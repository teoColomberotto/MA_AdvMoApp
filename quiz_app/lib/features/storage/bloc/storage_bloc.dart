import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/pokemon_image_model.dart';
import '../repository/storage_repository.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageRepository _storageRepository;
  StorageBloc(this._storageRepository) : super(StorageInitial()) {
    on<StorageEvent>((event, emit) async {
      if (event is StorageDownloadPokemonImage) {
        emit(const StorageLoading(message: 'Downloading pokemon image...'));
        try {
          PokemonImage pokemonImage = await _storageRepository
              .downloadPokemonImage(pokedexId: event.pokedexId);
          emit(StoragePokemonImageLoaded(pokemonImage: pokemonImage));
        } catch (e) {
          emit(StorageError());
        }
      }
    });
  }
}
