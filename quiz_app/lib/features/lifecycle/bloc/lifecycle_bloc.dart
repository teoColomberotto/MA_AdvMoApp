import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/enums.dart';
import 'package:equatable/equatable.dart';

part 'lifecycle_event.dart';
part 'lifecycle_state.dart';

class LifecycleBloc extends Bloc<AppLifecycleStateEvent, LifecycleState> {
  LifecycleBloc() : super(InactiveState()) {
    on<AppLifecycleStateEvent>((event, emit) {
      switch (event) {
        case AppLifecycleStateEvent.resumed:
          emit(ResumedState());
          break;
        case AppLifecycleStateEvent.inactive:
          emit(InactiveState());
          break;
        case AppLifecycleStateEvent.paused:
          emit(PausedState());
          break;
      }
    });
  }
}

class LifecycleObserver extends WidgetsBindingObserver {
  final BuildContext context;

  LifecycleObserver(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<LifecycleBloc>(context)
            .add(AppLifecycleStateEvent.resumed);
        break;
      case AppLifecycleState.inactive:
        BlocProvider.of<LifecycleBloc>(context)
            .add(AppLifecycleStateEvent.inactive);
        break;
      case AppLifecycleState.paused:
        BlocProvider.of<LifecycleBloc>(context)
            .add(AppLifecycleStateEvent.paused);
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
}
