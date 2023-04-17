import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/ticker_model.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late final int _duration;
  late final MyTicker _ticker;
  late StreamSubscription<int> tickerSubscription;

  TimerBloc({required duration, required MyTicker ticker})
      : super(Ready(duration)) {
    _ticker = ticker;
    _duration = duration;

    on<TimerEvent>((event, emit) {
      if (event is Start) {
        _mapStartToState(event, emit);
      } else if (event is Pause) {
        _mapPauseToState(event, emit);
      } else if (event is Resume) {
        _mapResumeToState(event, emit);
      } else if (event is Reset) {
        _mapResetToState(event, emit);
      } else if (event is Tick) {
        _mapTickToState(event, emit);
      }
    });
  }

  void _mapStartToState(Start event, Emitter<TimerState> emit) {
    emit(Running(event.duration));
    print("Timer bloc start");
    // tickerSubscription.cancel();
    tickerSubscription = _ticker.tick(ticks: event.duration).listen(
      (duration) {
        add(Tick(duration: duration));
      },
    );
  }

  void _mapPauseToState(Pause event, Emitter<TimerState> emit) {
    if (state is Running) {
      tickerSubscription.pause();
      emit(Paused(state.duration));
    }
  }

  void _mapResumeToState(Resume event, Emitter<TimerState> emit) {
    if (state is Paused) {
      tickerSubscription.resume();
      emit(Running(state.duration));
    }
  }

  void _mapResetToState(Reset event, Emitter<TimerState> emit) {
    tickerSubscription.cancel();
    emit(Ready(_duration));
  }

  void _mapTickToState(Tick event, Emitter<TimerState> emit) {
    event.duration > 0 ? emit(Running(event.duration)) : emit(const Finished());
  }

  @override
  Future<void> close() {
    tickerSubscription.cancel();
    return super.close();
  }
}
