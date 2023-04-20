import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:quiz_app/exceptions/pokemon_image_notfound.dart';

class StorageService {
  final FirebaseStorage storage;
  final Reference storageRef;

  StorageService({FirebaseStorage? storage})
      : storage = storage ?? FirebaseStorage.instance,
        storageRef = storage?.ref() ?? FirebaseStorage.instance.ref();

  Future<Uint8List>? downloadPokemonImage(int pokedexId) async {
    final ref = storageRef.child("pokemon/$pokedexId.png");

    const oneMegabyte = 1024 * 1024;
    final Uint8List? image =
        await ref.getData(oneMegabyte).catchError((e) => e);
    if (image == null || image == Uint8List(0)) {
      throw PokemonImageNotFound(pokedexId: pokedexId);
    }
    return image;
  }
}
