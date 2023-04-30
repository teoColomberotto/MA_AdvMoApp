import 'package:flutter/material.dart';

import '../models/quiz_model.dart';

class QuizRecapInfo extends StatelessWidget {
  final Quiz quiz;
  const QuizRecapInfo({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(alignment: AlignmentDirectional.center, children: [
        Positioned(
          bottom: 0,
          child: Card(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('Your Answers',
                        style: Theme.of(context).textTheme.headlineSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text('${quiz.correctAnswersCount}',
                                style:
                                    Theme.of(context).textTheme.headlineLarge),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 50,
                            ),
                            Text('${quiz.wrongAnswersCount}',
                                style:
                                    Theme.of(context).textTheme.headlineLarge),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            child: Card(
                child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 200,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('Your Score',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        '${quiz.scorePoints}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  )),
            )))
      ]),
    );
  }
}
