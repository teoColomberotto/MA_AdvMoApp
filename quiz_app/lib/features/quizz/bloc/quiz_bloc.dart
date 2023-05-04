import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/constants/constants.dart';
import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/exceptions/questions_lenght_exceeded_exception.dart';
import 'package:quiz_app/features/database/bloc/database_bloc.dart';
import 'package:quiz_app/features/quizz/bloc/timer_bloc.dart';
import 'package:quiz_app/features/storage/bloc/storage_bloc.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

import '../../connectivity/bloc/connectivity_bloc.dart';
import '../../database/models/pokemon_model.dart';
import '../../database/models/score_model.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  late final Quiz _quiz;
  final TimerBloc timerBloc;
  final DatabaseBloc databaseBloc;
  final StorageBloc storageBloc;
  final ConnectivityBloc connectivityBloc;
  late final StreamSubscription timerSubscription;
  late final StreamSubscription databaseSubscription;
  late final StreamSubscription strorageSubscription;
  late final StreamSubscription connectivitySubscription;

  QuizBloc(
      {required this.timerBloc,
      required this.databaseBloc,
      required this.storageBloc,
      required this.connectivityBloc})
      : super(QuizInitial()) {
    _quiz = Quiz();
    timerSubscription = timerBloc.stream.listen((timerState) {
      if (timerState is Ready) {
      } else if (timerState is Running) {
        // add(QuizTimerTick(duration: timerState.duration));
      } else if (timerState is Paused) {
      } else if (timerState is Finished) {
        int currentQuestionIndex = _quiz.currentQuestionIndex;
        add(QuizQuestionAnswered(
            currentQuestionIndex: currentQuestionIndex,
            duration: timerDuration));
      }
    });
    strorageSubscription = storageBloc.stream.listen((storageState) {
      if (storageState is StoragePokemonImageLoaded) {
        add(QuizDisplayPokemonImage(imageData: storageState.pokemonImage));
      }
    });
    databaseSubscription = databaseBloc.stream.listen((databaseState) {
      if (databaseState is DatabasePokemonsListLoaded) {
        add(QuizCreate(databaseState.pokemons));
      } else if (databaseState is DatabaseScoreAdded) {
        add(QuizScoreIsValid(score: databaseState.score));
      } else if (databaseState is DatabaseScoreNameAlreadyExists) {
        add(QuizScoreIsNotValid(scoreName: databaseState.name));
      }
    });
    connectivitySubscription =
        connectivityBloc.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnected) {
        add(QuizInternetDetected(connectivityState: connectivityState));
      } else if (connectivityState is ConnectivityDisconnected) {
        add(QuizNoInternetDetected());
      }
    });
    on<QuizEvent>((event, emit) {
      if (event is QuizStart) {
        mapQuizStartedToState(event, emit);
      } else if (event is QuizCreate) {
        mapQuizCreateToState(event, emit);
      } else if (event is QuizQuestionAnswered) {
        mapQuizQuestionAnsweredToState(event, emit);
      } else if (event is QuizShowCurrentQuestion) {
        mapQuizShowCurrentQuestionToState(event, emit);
      } else if (event is QuizIncrementCurrentQuestion) {
        mapQuizIncrementCurrentQuestionToState(event, emit);
      } else if (event is QuizDisplayPokemonImage) {
        mapQuizDisplayPokemonImageToState(event, emit);
      } else if (event is QuizFinish) {
        mapQuizFinishToState(event, emit);
      } else if (event is QuizShowScore) {
        mapQuizShowScoreToState(event, emit);
      } else if (event is QuizScoreSubmitted) {
        mapQuizScoreSubmittedToState(event, emit);
      } else if (event is QuizScoreSkipped) {
        mapQuizScoreSkippedToState(event, emit);
      } else if (event is QuizReset) {
        mapQuizResetToState(event, emit);
      } else if (event is QuizTimerTick) {
        mapQuizTimerTickToState(event, emit);
      } else if (event is QuizPause) {
        mapQuizPauseToState(event, emit);
      } else if (event is QuizResume) {
        mapQuizResumeToState(event, emit);
      } else if (event is QuizBackToHome) {
        mapQuizBackToHomeToState(event, emit);
      } else if (event is QuizScoreIsValid) {
        mapQuizScoreIsValidToState(event, emit);
      } else if (event is QuizScoreIsNotValid) {
        mapQuizScoreIsNotValidToState(event, emit);
      } else if (event is QuizNoInternetDetected) {
        mapQuizNoInternetDetectedToState(event, emit);
      } else if (event is QuizInternetDetected) {
        mapQuizInternetDetectedToState(event, emit);
      }
    });
  }

  void mapQuizStartedToState(QuizStart event, Emitter<QuizState> emit) {
    emit(const QuizLoading(message: 'Loading quiz...'));
    databaseBloc.add(const DatabaseGetPokemonsList(limit: 10));
  }

  void mapQuizCreateToState(QuizCreate event, Emitter<QuizState> emit) {
    List<Question> questions = [];
    for (var pokemon in event.pokemons) {
      questions.add(Question.fromPokemon(pokemon: pokemon));
    }
    _quiz.questions = questions;

    emit(QuizLoaded(quiz: _quiz));
    timerBloc.add(Start(duration: 5));
    add(QuizShowCurrentQuestion());
  }

  void mapQuizQuestionAnsweredToState(
      QuizQuestionAnswered event, Emitter<QuizState> emit) {
    Question currentQuestion = _quiz.currentQuestion;
    timerBloc.add(Reset());
    if (event.answerIndex != null) {
      currentQuestion.answerChoosedByUser = event.answerIndex;
      currentQuestion.timeRequiredToAnswer = event.duration;
      if (currentQuestion.pokemon.answers[event.answerIndex.toString()][1] ==
          true) {
        currentQuestion.answer = AnswerStatus.correct;
      } else {
        currentQuestion.answer = AnswerStatus.incorrect;
      }
      emit(QuizQuestionValidated(
          question: currentQuestion,
          currentQuestionIndex: _quiz.currentQuestionIndex));
    } else {
      currentQuestion.answer = AnswerStatus.incorrect;
      currentQuestion.answerChoosedByUser = null;
      currentQuestion.timeRequiredToAnswer = 0;

      emit(QuizQuestionValidated(
          question: currentQuestion,
          currentQuestionIndex: _quiz.currentQuestionIndex));
    }
  }

  void mapQuizIncrementCurrentQuestionToState(
      QuizIncrementCurrentQuestion event, Emitter<QuizState> emit) {
    //get the index of current question
    int currentQuestionIndex = _quiz.currentQuestionIndex;
    int questionsLenght = _quiz.questions.length;
    if (currentQuestionIndex + 1 < questionsLenght) {
      _quiz.currentQuestionIndex = currentQuestionIndex + 1;
    } else {
      throw QuestionsLenghtExceeded(index: currentQuestionIndex);
    }
    timerBloc.add(Start(duration: 5));
    add(QuizShowCurrentQuestion());
  }

  void mapQuizShowCurrentQuestionToState(
      QuizShowCurrentQuestion event, Emitter<QuizState> emit) {
    Question currentQuestion = _quiz.currentQuestion;
    for (var question in _quiz.questions) {
      question.status = QuestionStatus.inactive;
    }
    currentQuestion.status = QuestionStatus.active;
    storageBloc.add(StorageDownloadPokemonImage(
        pokedexId: currentQuestion.pokemon.pokedexId));
    emit(QuizQuestionShown(
        question: currentQuestion,
        currentQuestionIndex: _quiz.currentQuestionIndex));
  }

  void mapQuizDisplayPokemonImageToState(
      QuizDisplayPokemonImage event, Emitter<QuizState> emit) {
    Question currentQuestion = _quiz.currentQuestion;
    currentQuestion.pokemonImage = event.imageData;
    emit(QuizPokemonImageDisplayed(question: currentQuestion));
    emit(QuizQuestionShown(
        question: currentQuestion,
        currentQuestionIndex: _quiz.currentQuestionIndex));
  }

  void mapQuizFinishToState(QuizFinish event, Emitter<QuizState> emit) {
    _quiz.computeScore();
    emit(QuizFinished(quiz: _quiz));
  }

  void mapQuizShowScoreToState(QuizShowScore event, Emitter<QuizState> emit) {
    add(QuizShowScore());
  }

  void mapQuizScoreSubmittedToState(
      QuizScoreSubmitted event, Emitter<QuizState> emit) {
    int scorePoints = _quiz.scorePoints;
    Score score = Score(
        name: event.scoreName, score: scorePoints, timestamp: DateTime.now());
    _quiz.score = score;
    databaseBloc.add(DatabaseAddScore(score: score));
  }

  void mapQuizScoreSkippedToState(
      QuizScoreSkipped event, Emitter<QuizState> emit) {
    add(QuizReset());
  }

  void mapQuizResetToState(QuizReset event, Emitter<QuizState> emit) {
    _quiz.dispose();
    emit(QuizInitial());
  }

  void mapQuizTimerTickToState(QuizTimerTick event, Emitter<QuizState> emit) {
    emit(QuizTimerRunning(duration: event.duration));
  }

  void mapQuizPauseToState(QuizPause event, Emitter<QuizState> emit) {
    timerBloc.add(Pause());
    emit(QuizPaused());
  }

  void mapQuizResumeToState(QuizResume event, Emitter<QuizState> emit) {
    timerBloc.add(Resume());
    emit(QuizResumed());
  }

  void mapQuizBackToHomeToState(QuizBackToHome event, Emitter<QuizState> emit) {
    add(QuizPause());
    emit(QuizNavigateToHome());
  }

  void mapQuizScoreIsValidToState(
      QuizScoreIsValid event, Emitter<QuizState> emit) {
    emit(QuizScoreValidated(score: event.score));
  }

  void mapQuizScoreIsNotValidToState(
      QuizScoreIsNotValid event, Emitter<QuizState> emit) {
    emit(QuizScoreNotValid(scoreName: event.scoreName));
  }

  void mapQuizNoInternetDetectedToState(
      QuizNoInternetDetected event, Emitter<QuizState> emit) {
    add(QuizPause());
    emit(QuizPausedDueToNoInternetConnection());
  }

  void mapQuizInternetDetectedToState(
      QuizInternetDetected event, Emitter<QuizState> emit) {
    add(QuizResume());
    emit(QuizInternetConnectionRestored());
  }
}
