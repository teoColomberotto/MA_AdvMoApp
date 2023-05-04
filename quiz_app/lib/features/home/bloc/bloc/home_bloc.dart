import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../connectivity/bloc/connectivity_bloc.dart';
import '../../../quizz/bloc/quiz_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuizBloc quizBloc;
  final ConnectivityBloc connectivityBloc;
  late final StreamSubscription connectivitySubription;

  HomeBloc({required this.connectivityBloc, required this.quizBloc})
      : super(HomeInitial()) {
    connectivitySubription =
        connectivityBloc.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnected) {
      } else if (connectivityState is ConnectivityDisconnected) {}
    });

    on<HomeEvent>((event, emit) async {
      if (event is HomePlayPressed) {
        await mapHomePlayPressedToState(emit);
      } else if (event is HomeLeaderboardPressed) {
        mapHomeLeaderboardPressedToState(emit);
      } else if (event is HomeResetState) {
        emit(HomeInitial());
      } else if (event is HomeAboutPressed) {
        mapHomeAboutPressedToState(emit);
      }
    });
  }

  Future<void> mapHomePlayPressedToState(Emitter<HomeState> emit) async {
    await Connectivity().checkConnectivity().then((status) {
      if (status == ConnectivityResult.none) {
        if (!emit.isDone) {
          emit(const HomeQuizStartRefused(message: 'No internet connection'));
        }
      } else {
        quizBloc.add(QuizStart());
        emit(HomePlayButtonPressed());
      }
    }).onError((error, stackTrace) {
      log("error: $error");
    }).whenComplete(() {});
  }

  void mapHomeLeaderboardPressedToState(Emitter<HomeState> emit) {
    emit(HomeLeaderboardButtonPressed());
  }

  void mapHomeAboutPressedToState(Emitter<HomeState> emit) {
    emit(HomeAboutButtonPressed());
  }
}
