//create a singleton Quiz class that contain a list of Question and a score
import 'package:quiz_app/features/quizz/models/question_model.dart';

import '../../../constants/enums.dart';

class Quiz {
  List<Question> _questions;
  int _score = 0;

  static final Quiz _singleton = Quiz._internal();

  factory Quiz({required List<Question> questions}) {
    _singleton._questions = questions;
    return _singleton;
  }

  Quiz._internal() : _questions = [];

  int get score => _score;
  int get questionsCount => _questions.length;
  int get correctAnswersCount => _questions
      .where((question) => question.answer == AnswerStatus.correct)
      .length;
  int get wrongAnswersCount => _questions
      .where((question) => question.answer == AnswerStatus.incorrect)
      .length;

  List<Question> get questions => _questions;

  void updateQuestion(int index, Question question) {
    _questions[index] = question;
  }

  void computeScore() {
    _score = 0;
    for (final question in _questions) {
      if (question.answer == AnswerStatus.correct) {
        _score++;
      }
    }
  }
}
