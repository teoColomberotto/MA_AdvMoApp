part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizStarted extends QuizEvent {}

class QuizQuestionAnswered extends QuizEvent {
  final int questionIndex;
  final int answerIndex;

  const QuizQuestionAnswered({
    required this.questionIndex,
    required this.answerIndex,
  });

  @override
  List<Object> get props => [questionIndex, answerIndex];
}

class QuizFinish extends QuizEvent {}

class QuizShowScore extends QuizEvent {}

class QuizScoreSubmitted extends QuizEvent {
  final Score score;

  const QuizScoreSubmitted(this.score);

  @override
  List<Object> get props => [score];
}

class QuizScoreSkipped extends QuizEvent {}

class QuizReset extends QuizEvent {}
