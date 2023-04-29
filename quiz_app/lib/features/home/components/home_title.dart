import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class MyAppTitle extends StatelessWidget {
  const MyAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Pokemon Quiz',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
        Text('gotta find em all !',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.mySecondaryColor,
            )),
      ],
    );
  }
}
