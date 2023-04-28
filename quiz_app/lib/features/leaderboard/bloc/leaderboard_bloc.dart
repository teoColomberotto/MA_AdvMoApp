import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc() : super(LeaderboardInitial()) {
    on<LeaderboardEvent>((event, emit) {
      if (event is LeaderboardHomePressed) {
        _mapLeaderboardHomePressedToState(event, emit);
      } else if (event is LeaderboardResetState) {
        emit(LeaderboardInitial());
      }
    });
  }

  void _mapLeaderboardHomePressedToState(
      LeaderboardHomePressed event, Emitter<LeaderboardState> emit) {
    emit(LeaderboardHomeButtonPressed());
  }
}
