part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class LeaderboardLoad extends LeaderboardEvent {
  final int limit;
  const LeaderboardLoad({this.limit = 10});

  @override
  List<Object> get props => [limit];
}

class LeaderboardDisplay extends LeaderboardEvent {
  final Leaderboard leaderboard;
  const LeaderboardDisplay({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}

class LeaderboardHomePressed extends LeaderboardEvent {}

class LeaderboardResetState extends LeaderboardEvent {}
