import '../constants/constants.dart' as constants;

class QuestionsLenghtExceeded implements Exception {
  final int index;
  final String message;

  QuestionsLenghtExceeded(
      {required this.index,
      this.message = constants.QUESTIONS_LENGTH_EXCEEDED_ERROR});

  @override
  String toString() => message;
}
