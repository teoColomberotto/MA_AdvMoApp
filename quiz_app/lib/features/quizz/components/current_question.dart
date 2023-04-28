import 'package:flutter/material.dart';

import '../models/quiz_model.dart';

class MyCurrentQuestionDisplay extends StatelessWidget {
  final Quiz quiz;

  const MyCurrentQuestionDisplay({Key? key, required this.quiz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Question ${quiz.currentQuestionIndex + 1} of ${quiz.questionsCount}',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
