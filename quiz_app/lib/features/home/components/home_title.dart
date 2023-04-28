import 'package:flutter/material.dart';

class MyAppTitle extends StatelessWidget {
  const MyAppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Pokemon Quiz',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFDE476),
            )),
        Text('gotta find em all',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFDE476),
            )),
      ],
    );
  }
}
