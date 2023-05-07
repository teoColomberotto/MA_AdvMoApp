import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/play_settings/models/play_settings_model.dart';

import '../../../constants/enums.dart';

part 'play_settings_event.dart';
part 'play_settings_state.dart';

class PlaySettingsBloc extends Bloc<PlaySettingsEvent, PlaySettingsState> {
  PlaySettingsBloc() : super(PlaySettingsInitial()) {
    on<PlaySettingsEvent>((event, emit) {
      if (event is PlaySettingsReset) {
        _mapPlaySettingsResetToState(event, emit);
      } else if (event is PlaySettingsSubmitted) {
        _mapPlaySettingsValidatedToState(event, emit);
      }
    });
  }

  void _mapPlaySettingsResetToState(
      PlaySettingsReset event, Emitter<PlaySettingsState> emit) {
    emit(PlaySettingsResetted());
  }

  void _mapPlaySettingsValidatedToState(
      PlaySettingsSubmitted event, Emitter<PlaySettingsState> emit) {
    final PlaySettings playSettings = PlaySettings(
        difficulty: event.difficulty,
        numberOfQuestions: event.numberOfQuestions);
    emit(PlaySettingsValidated(playSettings: playSettings));
  }
}
