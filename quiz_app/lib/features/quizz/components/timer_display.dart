import 'package:flutter/material.dart';

import 'package:quiz_app/constants/constants.dart' as constants;

class MyTimerDisplay extends StatelessWidget {
  final int timeRemaining;
  final int totalTime = constants.timerDuration;

  const MyTimerDisplay({
    super.key,
    required this.timeRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 300,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                value: timeRemaining / totalTime,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            timeRemaining.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
