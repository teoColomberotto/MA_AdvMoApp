import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late final Ticker _ticker;
  late final StreamSubscription<int> tickerSubscription;

  TimerBloc({required duration, required Ticker ticker})
      : super(Ready(duration)) {
    _ticker = ticker;

    on<TimerEvent>((event, emit) {
      if (event is Start) {
        _mapStartToState(event);
      } else if (event is Pause) {
        _mapPauseToState(event);
      } else if (event is Resume) {
        _mapResumeToState(event);
      } else if (event is Reset) {
        _mapResetToState(event);
      } else if (event is Tick) {
        _mapTickToState(event);
      }
    });
  }

  void _mapStartToState(Start event) {}

  void _mapPauseToState(Pause event) {}

  void _mapResumeToState(Resume event) {}

  void _mapResetToState(Reset event) {}

  void _mapTickToState(Tick event) {}

  @override
  Future<void> close() {
    tickerSubscription.cancel();
    return super.close();
  }
}
