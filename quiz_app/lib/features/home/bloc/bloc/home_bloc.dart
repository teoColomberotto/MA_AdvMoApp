import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../quizz/bloc/quiz_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuizBloc quizBloc;

  HomeBloc({required this.quizBloc}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if (event is HomePlayPressed) {
        mapHomePlayPressedToState(emit);
      } else if (event is HomeLeaderboardPressed) {
        mapHomeLeaderboardPressedToState(emit);
      } else if (event is HomeResetState) {
        emit(HomeInitial());
      } else if (event is HomeAboutPressed) {
        mapHomeAboutPressedToState(emit);
      }
    });
  }

  void mapHomePlayPressedToState(Emitter<HomeState> emit) {
    quizBloc.add(QuizStart());
    emit(HomePlayButtonPressed());
  }

  void mapHomeLeaderboardPressedToState(Emitter<HomeState> emit) {
    emit(HomeLeaderboardButtonPressed());
  }

  void mapHomeAboutPressedToState(Emitter<HomeState> emit) {
    emit(HomeAboutButtonPressed());
  }
}
