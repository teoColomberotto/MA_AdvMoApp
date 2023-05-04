import 'package:flutter/material.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';
import '../models/quiz_model.dart';

class QuizRecapInfo extends StatelessWidget {
  final Quiz quiz;
  const QuizRecapInfo({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (myDeviceType == MyDeviceType.mobilePortrait ||
                      myDeviceType == MyDeviceType.tabletPortrait)
                  ? 250
                  : 150,
              minWidth: 150),
          child: Card(
            margin: const EdgeInsets.only(right: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your \nAnswers',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text('${quiz.correctAnswersCount}',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        '${quiz.wrongAnswersCount}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (myDeviceType == MyDeviceType.mobilePortrait ||
                      myDeviceType == MyDeviceType.tabletPortrait)
                  ? 250
                  : 150,
              minWidth: 150),
          child: Card(
              margin: const EdgeInsets.only(left: 10.0),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your \nScore',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${quiz.scorePoints}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ))),
        ),
      )
    ]);
  }
}
