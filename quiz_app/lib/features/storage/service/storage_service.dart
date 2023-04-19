import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<Uint8List>? downloadPokemonImage(int pokedexId) async {
    final ref = storageRef.child("pokemon/$pokedexId.png");

    const oneMegabyte = 1024 * 1024;
    final Uint8List? image =
        await ref.getData(oneMegabyte).catchError((e) => e);

    return image!;
  }
}
