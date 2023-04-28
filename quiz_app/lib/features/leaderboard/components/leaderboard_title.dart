import 'package:flutter/material.dart';

class MyLeaderboardTitle extends StatelessWidget {
  const MyLeaderboardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Leaderboard',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: Color(0xFFFDE476),
        ));
  }
}
