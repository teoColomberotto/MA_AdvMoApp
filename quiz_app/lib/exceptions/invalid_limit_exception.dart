import '../constants/constants.dart' as constants;

class InvalidLimitValue implements Exception {
  final int limit;
  final String message;

  InvalidLimitValue(
      {required this.limit,
      this.message = constants.INVALID_LIMIT_VALUE_ERROR});

  @override
  String toString() => message;
}
