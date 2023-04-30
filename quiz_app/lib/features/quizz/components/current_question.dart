import 'package:flutter/material.dart';
import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/utils/utils.dart';

import '../models/quiz_model.dart';

class MyCurrentQuestionDisplay extends StatelessWidget {
  final Quiz quiz;

  const MyCurrentQuestionDisplay({Key? key, required this.quiz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokemonType pokemonType = quiz.currentQuestion.pokemon.type;
    final Color backgroundColor = mapBackgroundColorToPokemonType(pokemonType);
    final Color textColor = getFontColorForBackground(backgroundColor);

    return Text(
      'Question ${quiz.currentQuestionIndex + 1} of ${quiz.questionsCount}',
      style: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
