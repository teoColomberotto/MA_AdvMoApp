import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class PokemonImage extends Equatable {
  const PokemonImage({
    required this.imageData,
  });

  final Uint8List imageData;

  factory PokemonImage.fromStorageData(Uint8List imageData) {
    return PokemonImage(
      imageData: imageData,
    );
  }

  @override
  List<Object?> get props => [
        imageData,
      ];
}
