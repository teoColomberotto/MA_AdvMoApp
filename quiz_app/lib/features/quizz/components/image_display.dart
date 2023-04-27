import 'dart:typed_data';

import 'package:flutter/material.dart';

class MyPokemonImage extends StatelessWidget {
  final Uint8List imageData;
  final bool show;

  const MyPokemonImage(
      {super.key, required this.imageData, required this.show});

  @override
  Widget build(BuildContext context) {
    if (imageData.isEmpty) {
      return const SizedBox(
        height: 256,
        width: 256,
        child: CircularProgressIndicator(),
      );
    }
    switch (show) {
      case true:
        return SizedBox(
          height: 256,
          width: 256,
          child: Image.memory(imageData),
        );
      case false:
        return SizedBox(
          height: 256,
          width: 256,
          child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              child: Image.memory(imageData)),
        );
      default:
        return const SizedBox(
          height: 256,
          width: 256,
          child:
              Image(image: AssetImage('assets/images/defaultPokemonImage.png')),
        );
    }
  }
}
