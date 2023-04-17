//create a Question model that contain a Pokemon object, a boolean answer and a String question
import 'dart:typed_data';

import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../../database/models/pokemon_model.dart';

class Question {
  final Pokemon pokemon;
  AnswerStatus _answerStatus = AnswerStatus.unanswered;
  QuestionStatus _status = QuestionStatus.inactive;
  late int? answerChoosedByUser;
  int timeRequiredToAnswer = 0;
  late PokemonImage _pokemonImage;

  Question({
    required this.pokemon,
    required PokemonImage pokemonImage,
  }) : _pokemonImage = pokemonImage;

  factory Question.fromPokemon({required Pokemon pokemon}) {
    return Question(
      pokemon: pokemon,
      pokemonImage: PokemonImage(imageData: Uint8List(0)),
    );
  }

  AnswerStatus get answer => _answerStatus;
  QuestionStatus get status => _status;
  PokemonImage get pokemonImage => _pokemonImage;

  set answer(AnswerStatus value) {
    _answerStatus = value;
  }

  set pokemonImage(PokemonImage value) {
    _pokemonImage = value;
  }

  set status(QuestionStatus value) {
    _status = value;
  }
}
