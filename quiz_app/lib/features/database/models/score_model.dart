import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  String _name;
  int score = 0;
  DateTime timestamp = DateTime.now();

  Score({
    required name,
    required this.score,
    required this.timestamp,
  }) : _name = name;

  factory Score.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Score(
      name: doc.data()!['name'],
      score: doc.data()!['score'],
      timestamp: doc.data()!['timestamp'].toDate(),
    );
  }

  String get name => _name;
  set name(String name) => _name = name;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'score': score,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
