import 'package:flutter/material.dart';
import 'package:quiz_app/constants/breakpoints.dart';
import 'package:quiz_app/constants/colors.dart';
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

Color getFontColorForBackground(Color background) {
  return (background.computeLuminance() > 0.5)
      ? MyColors.myBlack
      : MyColors.myWhite;
}

MyDeviceType getDeviceTypeFromMediaQuery(MediaQueryData mediaQuery) {
  if (mediaQuery.orientation == Orientation.landscape) {
    if (mediaQuery.size.height >= MyBreakpoints.kDesktopMinWidth &&
        mediaQuery.size.width >= MyBreakpoints.kDesktopMinHeight &&
        mediaQuery.size.height <= MyBreakpoints.kDesktopMaxWidth &&
        mediaQuery.size.width <= MyBreakpoints.kDesktopMaxHeight) {
      // Device is a desktop computer in landscape orientation
      return MyDeviceType.desktopLandscape;
    } else if (mediaQuery.size.height >= MyBreakpoints.kTabletMinWidth &&
        mediaQuery.size.width >= MyBreakpoints.kTabletMinHeight &&
        mediaQuery.size.height <= MyBreakpoints.kTabletMaxWidth &&
        mediaQuery.size.width <= MyBreakpoints.kTabletMaxHeight) {
      // Device is a tablet in landscape orientation
      return MyDeviceType.tabletLandscape;
    } else {
      // Device is a mobile phone in landscape orientation
      return MyDeviceType.mobileLandscape;
    }
  } else if (mediaQuery.orientation == Orientation.portrait) {
    if (mediaQuery.size.height >= MyBreakpoints.kDesktopMinHeight &&
        mediaQuery.size.width >= MyBreakpoints.kDesktopMinWidth &&
        mediaQuery.size.height <= MyBreakpoints.kDesktopMaxHeight &&
        mediaQuery.size.width <= MyBreakpoints.kDesktopMaxWidth) {
      // Device is a desktop computer in portrait orientation
      return MyDeviceType.desktopPortrait;
    } else if (mediaQuery.size.height >= MyBreakpoints.kTabletMinHeight &&
        mediaQuery.size.width >= MyBreakpoints.kTabletMinWidth &&
        mediaQuery.size.height <= MyBreakpoints.kTabletMaxHeight &&
        mediaQuery.size.width <= MyBreakpoints.kTabletMaxWidth) {
      // Device is a tablet in portrait orientation
      return MyDeviceType.tabletPortrait;
    } else {
      // Device is a mobile phone in portrait orientation
      return MyDeviceType.mobilePortrait;
    }
  } else {
    // Device is a desktop computer in landscape orientation
    return MyDeviceType.desktopLandscape;
  }
}

int mapDifficultyToTimerDuration({required Difficulty difficulty}) {
  switch (difficulty) {
    case Difficulty.easy:
      return 20;
    case Difficulty.medium:
      return 10;
    case Difficulty.hard:
      return 5;
    default:
      return 5;
  }
}
