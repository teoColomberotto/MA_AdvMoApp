part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {
  final String message;

  const QuizLoading({required this.message});
}

class QuizLoaded extends QuizState {
  final Quiz quiz;

  const QuizLoaded({required this.quiz});

  @override
  List<Object> get props => [quiz];
}

class QuizQuestionShown extends QuizState {
  final Question question;
  final int currentQuestionIndex;

  const QuizQuestionShown(
      {required this.question, required this.currentQuestionIndex});

  @override
  List<Object> get props => [question];
}

class QuizQuestionValidated extends QuizState {
  final Question question;
  final int currentQuestionIndex;

  const QuizQuestionValidated(
      {required this.question, required this.currentQuestionIndex});

  @override
  List<Object> get props => [question];
}

class QuizFinished extends QuizState {
  final Quiz quiz;

  const QuizFinished({required this.quiz});

  @override
  List<Object> get props => [quiz];
}

class QuizScoreDisplayed extends QuizState {
  final Quiz quiz;

  const QuizScoreDisplayed(this.quiz);

  @override
  List<Object> get props => [quiz];
}

class QuizPokemonImageDisplayed extends QuizState {
  final Question question;

  const QuizPokemonImageDisplayed({required this.question});

  @override
  List<Object> get props => [question];
}

class QuizTimerRunning extends QuizState {
  final int duration;

  const QuizTimerRunning({required this.duration});

  @override
  List<Object> get props => [duration];
}

class QuizError extends QuizState {
  final String message;

  const QuizError({required this.message});
}
