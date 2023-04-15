import '../constants/constants.dart' as constants;

class ScoreNameException implements Exception {
  final String message;
  final String name;

  ScoreNameException(
      {this.message = constants.SCORE_NAME_DUPLICATE_ERROR,
      required this.name});

  @override
  String toString() => message;
}
