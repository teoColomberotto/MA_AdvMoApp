part of 'play_settings_bloc.dart';

abstract class PlaySettingsEvent extends Equatable {
  const PlaySettingsEvent();

  @override
  List<Object> get props => [];
}

class PlaySettingsSubmitted extends PlaySettingsEvent {
  final Difficulty difficulty;
  final int numberOfQuestions;

  const PlaySettingsSubmitted({
    required this.difficulty,
    required this.numberOfQuestions,
  });

  @override
  List<Object> get props => [difficulty, numberOfQuestions];
}

class PlaySettingsReset extends PlaySettingsEvent {}
