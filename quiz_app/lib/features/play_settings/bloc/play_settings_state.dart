part of 'play_settings_bloc.dart';

abstract class PlaySettingsState extends Equatable {
  const PlaySettingsState();

  @override
  List<Object> get props => [];
}

class PlaySettingsInitial extends PlaySettingsState {}

class PlaySettingsResetted extends PlaySettingsState {}

class PlaySettingsValidated extends PlaySettingsState {
  final PlaySettings playSettings;

  const PlaySettingsValidated({required this.playSettings});

  @override
  List<Object> get props => [playSettings];
}
