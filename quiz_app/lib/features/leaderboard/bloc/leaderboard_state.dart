part of 'leaderboard_bloc.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardHomeButtonPressed extends LeaderboardState {}

class LeaderboardDisplayed extends LeaderboardState {
  final Leaderboard leaderboard;

  const LeaderboardDisplayed(this.leaderboard);

  @override
  List<Object> get props => [leaderboard];
}
