import 'package:flutter/material.dart';
import 'package:quiz_app/constants/colors.dart';

import 'package:quiz_app/constants/constants.dart' as constants;

import '../../../utils/utils.dart';

class MyTimerDisplay extends StatelessWidget {
  final int timeRemaining;
  final int totalTime = constants.timerDuration;

  final Color background;

  const MyTimerDisplay({
    super.key,
    required this.timeRemaining,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    final Color barColor = getFontColorForBackground(background);
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
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            timeRemaining.toString(),
            style: TextStyle(
              color: barColor == MyColors.myWhite
                  ? MyColors.myBlack
                  : MyColors.myWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
