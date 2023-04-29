import 'package:flutter/material.dart';
import 'package:quiz_app/constants/enums.dart';

Color mapBackgroundColorToPokemonType(PokemonType type) {
  switch (type) {
    case PokemonType.bug:
      return Colors.lightGreen[300]!;
    case PokemonType.dark:
      return Colors.grey[800]!;
    case PokemonType.dragon:
      return Colors.indigo[400]!;
    case PokemonType.electric:
      return Colors.yellow[400]!;
    case PokemonType.fairy:
      return Colors.pink[300]!;
    case PokemonType.fighting:
      return Colors.orange[400]!;
    case PokemonType.fire:
      return Colors.red[400]!;
    case PokemonType.flying:
      return Colors.indigo[100]!;
    case PokemonType.ghost:
      return Colors.indigo[400]!;
    case PokemonType.grass:
      return Colors.green[400]!;
    case PokemonType.ground:
      return Colors.brown[400]!;
    case PokemonType.ice:
      return Colors.cyan[100]!;
    case PokemonType.normal:
      return Colors.grey[400]!;
    case PokemonType.poison:
      return Colors.purple[400]!;
    case PokemonType.psychic:
      return Colors.pink[400]!;
    case PokemonType.rock:
      return Colors.brown[400]!;
    case PokemonType.steel:
      return Colors.blueGrey[400]!;
    case PokemonType.water:
      return Colors.blue[400]!;
    case PokemonType.unknown:
      return Colors.grey[400]!;
    case PokemonType.shadow:
      return Colors.grey[400]!;
  }
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
