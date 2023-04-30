import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class MyAboutTitle extends StatelessWidget {
  const MyAboutTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('How to Play ?',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text("First rule of quiz club, don't panic",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }
}
