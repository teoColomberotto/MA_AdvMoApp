part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizStart extends QuizEvent {}

class QuizCreate extends QuizEvent {
  final List<Pokemon> pokemons;

  const QuizCreate(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class QuizQuestionAnswered extends QuizEvent {
  final int currentQuestionIndex;
  final int? answerIndex;

  const QuizQuestionAnswered({
    required this.currentQuestionIndex,
    this.answerIndex,
  });

  @override
  List<Object> get props => [currentQuestionIndex];
}

class QuizIncrementCurrentQuestion extends QuizEvent {}

class QuizShowCurrentQuestion extends QuizEvent {}

class QuizDisplayPokemonImage extends QuizEvent {
  final PokemonImage imageData;

  const QuizDisplayPokemonImage({required this.imageData});

  @override
  List<Object> get props => [imageData];
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

class QuizTimerTick extends QuizEvent {
  final int duration;

  const QuizTimerTick({required this.duration});

  @override
  List<Object> get props => [duration];
}
