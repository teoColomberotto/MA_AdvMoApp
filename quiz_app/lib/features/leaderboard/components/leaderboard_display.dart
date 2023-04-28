import 'package:flutter/material.dart';

import '../../database/models/leaderboard_model.dart';
import '../../database/models/score_model.dart';
import 'my_score_tile.dart';

class MyLeaderboardDisplay extends StatelessWidget {
  final Leaderboard leaderboard;

  const MyLeaderboardDisplay({super.key, required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaderboard.leaderboard.length,
      itemBuilder: (BuildContext context, int index) {
        Score score = leaderboard.leaderboard[index];
        return MyScoreTile(
          score: score,
          index: index + 1,
        );
      },
    );
  }
}
