import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/constants/enums.dart';
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
    timerSubscription = timerBloc.stream.listen((timerState) {});
    strorageSubscription = storageBloc.stream.listen((storageState) {
      if (storageState is StoragePokemonImageLoaded) {
        print("image data from database: ${storageState.pokemonImage}");
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
      } else if (event is QuizShowNextQuestion) {
        mapQuizShowNextQuestionToState(event, emit);
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
    add(const QuizShowNextQuestion(currentQuestionIndex: 0));
  }

  void mapQuizQuestionAnsweredToState(
      QuizQuestionAnswered event, Emitter<QuizState> emit) {
    _currentQuestion = _quiz.questions[event.currentQuestionIndex];
    if (_currentQuestion.pokemon.answers[event.answerIndex] == true) {
      _currentQuestion.answer = AnswerStatus.correct;
    } else {
      _currentQuestion.answer = AnswerStatus.incorrect;
    }
    emit(QuizQuestionValidated(question: _currentQuestion));
  }

  void mapQuizShowNextQuestionToState(
      QuizShowNextQuestion event, Emitter<QuizState> emit) {
    for (var question in _quiz.questions) {
      question.status = QuestionStatus.inactive;
    }
    _currentQuestion = _quiz.questions[event.currentQuestionIndex];
    _currentQuestion.status = QuestionStatus.active;

    // if (currentQuestion.pokemonImage.imageData == []) {
    storageBloc.add(StorageDownloadPokemonImage(
        pokedexId: _currentQuestion.pokemon.pokedexId));
    // }
    emit(QuizQuestionShown(question: _currentQuestion));
  }

  void mapQuizDisplayPokemonImageToState(
      QuizDisplayPokemonImage event, Emitter<QuizState> emit) {
    _currentQuestion.pokemonImage = event.imageData;
    print("image data in current question: ${_currentQuestion.pokemonImage}");
    emit(QuizPokemonImageDisplayed(question: _currentQuestion));
  }

  void mapQuizFinishToState(QuizFinish event, Emitter<QuizState> emit) {}

  void mapQuizShowScoreToState(QuizShowScore event, Emitter<QuizState> emit) {}

  void mapQuizScoreSubmittedToState(
      QuizScoreSubmitted event, Emitter<QuizState> emit) {}

  void mapQuizScoreSkippedToState(
      QuizScoreSkipped event, Emitter<QuizState> emit) {}

  void mapQuizResetToState(QuizReset event, Emitter<QuizState> emit) {}
}
