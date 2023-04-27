import 'package:flutter/material.dart';

import '../models/quiz_model.dart';

class QuizRecapInfo extends StatelessWidget {
  final Quiz quiz;
  const QuizRecapInfo({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Correct Answers:', style: TextStyle(fontSize: 16.0)),
              Text('${quiz.correctAnswersCount}',
                  style: const TextStyle(fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Wrong Answers:', style: TextStyle(fontSize: 16.0)),
              Text('${quiz.wrongAnswersCount}',
                  style: const TextStyle(fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total question answered:',
                  style: TextStyle(fontSize: 16.0)),
              Text('${quiz.questionsCount}',
                  style: const TextStyle(fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 16.0),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/quizRecap_scoreBackground.png',
                width: 500.0,
              ), // Set PNG image as background
              Column(
                children: [
                  const SizedBox(height: 16.0),
                  const Text('Score:', style: TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 8.0),
                  Text('${quiz.scorePoints}',
                      style: const TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
