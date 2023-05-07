//create a singleton Quiz class that contain a list of Question and a score
// ignore_for_file: unnecessary_getters_setters

import 'package:quiz_app/features/quizz/models/question_model.dart';

import '../../../constants/enums.dart';
import '../../database/models/score_model.dart';

class Quiz {
  List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _scorePoints = 0;
  late Score _score;
  int _timerDuration;

  static final Quiz _singleton = Quiz._internal();

  factory Quiz() {
    return _singleton;
  }

  Quiz._internal()
      : _questions = [],
        _timerDuration = 0;

  Score get score => _score;
  int get scorePoints => _scorePoints;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get questionsCount => _questions.length;
  int get correctAnswersCount => _questions
      .where((question) => question.answer == AnswerStatus.correct)
      .length;
  int get wrongAnswersCount => _questions
      .where((question) => question.answer == AnswerStatus.incorrect)
      .length;
  List<Question> get questions => _questions;
  int get timerDuration => _timerDuration;

  set currentQuestionIndex(int index) => _currentQuestionIndex = index;
  set score(Score value) => _score = value;
  set questions(List<Question> value) => _questions = value;
  set timerDuration(int value) => _timerDuration = value;

  void resetQuiz() {
    Quiz._internal();
  }

  void computeScore() {
    int score = 0;
    for (final question in _questions) {
      if (question.answer == AnswerStatus.correct) {
        score += 10 * question.timeRequiredToAnswer;
      }
    }
    _scorePoints = score;
  }

  void dispose() {
    _questions = [];
    _currentQuestionIndex = 0;
  }
}
