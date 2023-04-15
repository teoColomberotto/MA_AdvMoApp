import 'package:quiz_app/features/database/models/score_model.dart';

class Leaderboard extends Score {
  final List<Score> leaderboard;

  Leaderboard({
    required this.leaderboard,
  }) : super(
          name: '',
          score: 0,
          timestamp: DateTime.now(),
        );

  factory Leaderboard.fromScoreList(List<Score> scores) {
    return Leaderboard(
      leaderboard: scores,
    );
  }

  @override
  List<Object?> get props => [
        leaderboard,
      ];
}
