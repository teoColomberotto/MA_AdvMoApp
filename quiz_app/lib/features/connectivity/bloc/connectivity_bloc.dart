import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late final StreamSubscription<ConnectivityResult>? _subscription;

  ConnectivityBloc() : super(ConnectivityUnknown()) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      add(ConnectivityChanged(connectivityResult: result));
    });

    on<ConnectivityEvent>((event, emit) {
      if (event is ConnectivityChanged) {
        if (event.connectivityResult == ConnectivityResult.none) {
          emit(ConnectivityDisconnected());
        } else {
          emit(ConnectivityConnected(event.connectivityResult));
        }
      } else if (event is ConnectivityCheck) {
        mapConnectivityCheckToState(emit);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void mapConnectivityCheckToState(Emitter<ConnectivityState> emit) async {
    emit(ConnectivityCheckInProgress());
    final connectivityResult = await Connectivity().checkConnectivity();
    add(ConnectivityChanged(connectivityResult: connectivityResult));
  }
}
