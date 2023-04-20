import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  final String _name;
  final int score;
  final DateTime timestamp;

  const Score({
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

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'score': score,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  @override
  List<Object?> get props => [_name, score, timestamp];
}
