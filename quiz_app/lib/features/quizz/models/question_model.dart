//create a Question model that contain a Pokemon object, a boolean answer and a String question
import 'dart:typed_data';

import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../../database/models/pokemon_model.dart';

class Question {
  final Pokemon pokemon;
  QuestionStatus _answer = QuestionStatus.unanswered;
  int timeRequiredToAnswer = 0;
  late final PokemonImage _pokemonImage;

  Question({
    required this.pokemon,
    required PokemonImage pokemonImage,
  }) : _pokemonImage = pokemonImage;

  factory Question.fromPokemon(Pokemon pokemon, bool answer) {
    return Question(
      pokemon: pokemon,
      pokemonImage: PokemonImage.fromStorageData(Uint8List(0)),
    );
  }

  QuestionStatus get answer => _answer;

  set answer(QuestionStatus answer) {
    _answer = answer;
  }

  set pokemonImage(PokemonImage pokemonImage) {
    this.pokemonImage = pokemonImage;
  }
}
