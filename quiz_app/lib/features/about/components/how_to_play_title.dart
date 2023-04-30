import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class MyHowToPlayTitle extends StatelessWidget {
  final String title;

  const MyHowToPlayTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: MyColors.myBlack,
            ));
  }
}
