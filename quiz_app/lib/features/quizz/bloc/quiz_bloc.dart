import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/models/score_model.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>((event, emit) {
      if (event is QuizStarted) {
        mapQuizStartedToState(event, emit);
      } else if (event is QuizQuestionAnswered) {
        mapQuizQuestionAnsweredToState(event, emit);
      } else if (event is QuizFinish) {
        mapQuizFinishToState(event, emit);
      } else if (event is QuizShowScore) {
        mapQuizShowScoreToState(event, emit);
      } else if (event is QuizScoreSubmitted) {
        mapQuizScoreSubmittedToState(event, emit);
      } else if (event is QuizScoreSkipped) {
        mapQuizScoreSkippedToState(event, emit);
      } else if (event is QuizReset) {
        mapQuizResetToState(event, emit);
      }
    });
  }

  void mapQuizStartedToState(QuizStarted event, Emitter<QuizState> emit) {}

  void mapQuizQuestionAnsweredToState(
      QuizQuestionAnswered event, Emitter<QuizState> emit) {}

  void mapQuizFinishToState(QuizFinish event, Emitter<QuizState> emit) {}

  void mapQuizShowScoreToState(QuizShowScore event, Emitter<QuizState> emit) {}

  void mapQuizScoreSubmittedToState(
      QuizScoreSubmitted event, Emitter<QuizState> emit) {}

  void mapQuizScoreSkippedToState(
      QuizScoreSkipped event, Emitter<QuizState> emit) {}

  void mapQuizResetToState(QuizReset event, Emitter<QuizState> emit) {}
}
