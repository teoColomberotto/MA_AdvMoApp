import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

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
        child: Padding(
          padding: EdgeInsets.all(80.0),
          child: CircularProgressIndicator(),
        ),
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
              colorFilter: ColorFilter.mode(MyColors.myBlack, BlendMode.srcIn),
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
