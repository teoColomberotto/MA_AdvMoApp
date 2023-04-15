import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<PokemonImage> downloadPokemonImage(int pokedexId) async {
    final ref = storageRef.child("pokemon/$pokedexId.png");

    const oneMegabyte = 1024 * 1024;
    final Uint8List? image = await ref
        .getData(oneMegabyte)
        .catchError((e) => print("storage service error: " + e));

    PokemonImage pokemonImage = PokemonImage.fromStorageData(image!);
    return pokemonImage;
  }
}
