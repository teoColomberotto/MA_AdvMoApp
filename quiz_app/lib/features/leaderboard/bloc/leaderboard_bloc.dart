import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/bloc/database_bloc.dart';
import '../../database/models/leaderboard_model.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final DatabaseBloc databaseBloc;
  late final StreamSubscription databaseSubscription;
  LeaderboardBloc({
    required this.databaseBloc,
  }) : super(LeaderboardInitial()) {
    databaseSubscription = databaseBloc.stream.listen((databaseState) {
      if (databaseState is DatabaseLeaderboardLoaded) {
        add(LeaderboardDisplay(leaderboard: databaseState.leaderboard));
      }
    });
    on<LeaderboardEvent>((event, emit) {
      if (event is LeaderboardHomePressed) {
        _mapLeaderboardHomePressedToState(event, emit);
      } else if (event is LeaderboardResetState) {
        emit(LeaderboardInitial());
      } else if (event is LeaderboardLoad) {
        _mapLeaderboardLoadToState(event, emit);
      } else if (event is LeaderboardDisplay) {
        _mapLeaderboardDisplayToState(event, emit);
      }
    });
  }

  void _mapLeaderboardHomePressedToState(
      LeaderboardHomePressed event, Emitter<LeaderboardState> emit) {
    emit(LeaderboardHomeButtonPressed());
  }

  void _mapLeaderboardLoadToState(
      LeaderboardLoad event, Emitter<LeaderboardState> emit) {
    databaseBloc.add(DatabaseGetLeaderboard(limit: event.limit));
  }

  void _mapLeaderboardDisplayToState(
      LeaderboardDisplay event, Emitter<LeaderboardState> emit) {
    emit(LeaderboardDisplayed(event.leaderboard));
  }
}
