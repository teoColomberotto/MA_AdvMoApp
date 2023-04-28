import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<AboutEvent>((event, emit) {
      if (event is AboutHomePressed) {
        _mapAboutHomePressedToState(event, emit);
      } else if (event is AboutResetState) {
        emit(AboutInitial());
      }
    });
  }

  void _mapAboutHomePressedToState(
      AboutHomePressed event, Emitter<AboutState> emit) {
    emit(AboutHomeButtonPressed());
  }
}
