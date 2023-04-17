import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/constants/enums.dart';
import 'package:quiz_app/exceptions/questionsLenghtExceeded_exception.dart';
import 'package:quiz_app/features/database/bloc/database_bloc.dart';
import 'package:quiz_app/features/quizz/bloc/timer_bloc.dart';
import 'package:quiz_app/features/storage/bloc/storage_bloc.dart';
import 'package:quiz_app/features/storage/models/pokemon_image_model.dart';

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
  late Question _currentQuestion;
  late final StreamSubscription timerSubscription;
  late final StreamSubscription databaseSubscription;
  late final StreamSubscription strorageSubscription;

  QuizBloc(
      {required this.timerBloc,
      required this.databaseBloc,
      required this.storageBloc})
      : super(QuizInitial()) {
    timerSubscription = timerBloc.stream.listen((timerState) {
      if (timerState is Ready) {
      } else if (timerState is Running) {
        print('remaining time: ${timerState.duration}');
        // add(QuizTimerTick(duration: timerState.duration));
      } else if (timerState is Paused) {
      } else if (timerState is Finished) {
        int currentQuestionIndex = _quiz.questions.indexOf(_currentQuestion);
        add(QuizQuestionAnswered(currentQuestionIndex: currentQuestionIndex));
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
    _quiz = Quiz(questions: questions);
    _currentQuestion = _quiz.questions[0];
    emit(QuizLoaded(quiz: _quiz));
    timerBloc.add(Start(duration: 5));
    add(QuizShowCurrentQuestion());
  }

  void mapQuizQuestionAnsweredToState(
      QuizQuestionAnswered event, Emitter<QuizState> emit) {
    timerBloc.add(Reset());
    if (event.answerIndex != null) {
      print("user has answered the question");
      _currentQuestion = _quiz.questions[event.currentQuestionIndex];
      _currentQuestion.answerChoosedByUser = event.answerIndex;
      if (_currentQuestion.pokemon.answers[event.answerIndex.toString()][1] ==
          true) {
        _currentQuestion.answer = AnswerStatus.correct;
      } else {
        _currentQuestion.answer = AnswerStatus.incorrect;
      }
      emit(QuizQuestionValidated(
          question: _currentQuestion,
          currentQuestionIndex: _quiz.questions.indexOf(_currentQuestion)));
    } else {
      print("timer expired");
      _currentQuestion.answer = AnswerStatus.incorrect;
      _currentQuestion.answerChoosedByUser = null;

      emit(QuizQuestionValidated(
          question: _currentQuestion,
          currentQuestionIndex: _quiz.questions.indexOf(_currentQuestion)));
    }
  }

  void mapQuizIncrementCurrentQuestionToState(
      QuizIncrementCurrentQuestion event, Emitter<QuizState> emit) {
    //get the index of current question
    int currentQuestionIndex = _quiz.questions.indexOf(_currentQuestion);
    int questionsLenght = _quiz.questions.length;
    if (currentQuestionIndex + 1 < questionsLenght) {
      _currentQuestion = _quiz.questions[currentQuestionIndex + 1];
    } else {
      throw QuestionsLenghtExceeded(index: currentQuestionIndex);
    }
    timerBloc.add(Start(duration: 5));
    add(QuizShowCurrentQuestion());
  }

  void mapQuizShowCurrentQuestionToState(
      QuizShowCurrentQuestion event, Emitter<QuizState> emit) {
    for (var question in _quiz.questions) {
      question.status = QuestionStatus.inactive;
    }
    _currentQuestion.status = QuestionStatus.active;
    storageBloc.add(StorageDownloadPokemonImage(
        pokedexId: _currentQuestion.pokemon.pokedexId));
    emit(QuizQuestionShown(
        question: _currentQuestion,
        currentQuestionIndex: _quiz.questions.indexOf(_currentQuestion)));
  }

  void mapQuizDisplayPokemonImageToState(
      QuizDisplayPokemonImage event, Emitter<QuizState> emit) {
    _currentQuestion.pokemonImage = event.imageData;
    // print("image data in current question: ${_currentQuestion.pokemonImage}");
    emit(QuizPokemonImageDisplayed(question: _currentQuestion));
    emit(QuizQuestionShown(
        question: _currentQuestion,
        currentQuestionIndex: _quiz.questions.indexOf(_currentQuestion)));
  }

  void mapQuizFinishToState(QuizFinish event, Emitter<QuizState> emit) {
    emit(QuizFinished(quiz: _quiz));
  }

  void mapQuizShowScoreToState(QuizShowScore event, Emitter<QuizState> emit) {}

  void mapQuizScoreSubmittedToState(
      QuizScoreSubmitted event, Emitter<QuizState> emit) {}

  void mapQuizScoreSkippedToState(
      QuizScoreSkipped event, Emitter<QuizState> emit) {}

  void mapQuizResetToState(QuizReset event, Emitter<QuizState> emit) {}

  void mapQuizTimerTickToState(QuizTimerTick event, Emitter<QuizState> emit) {
    emit(QuizTimerRunning(duration: event.duration));
  }
}
