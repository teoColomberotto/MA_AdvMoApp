// ignore_for_file: unnecessary_getters_setters

import 'package:quiz_app/constants/enums.dart';

class PlaySettings {
  late Difficulty _difficulty;
  late int _numberOfQuestions;

  PlaySettings({
    Difficulty difficulty = Difficulty.easy,
    int numberOfQuestions = 10,
  })  : _difficulty = difficulty,
        _numberOfQuestions = numberOfQuestions;

  Difficulty get difficulty => _difficulty;
  int get numberOfQuestions => _numberOfQuestions;

  set difficulty(Difficulty value) {
    _difficulty = value;
  }

  set numberOfQuestions(int value) {
    _numberOfQuestions = value;
  }
}
