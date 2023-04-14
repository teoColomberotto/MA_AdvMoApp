import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  final String name;
  final int score;
  final DateTime timestamp;

  Score({
    required this.name,
    required this.score,
    required this.timestamp,
  });

  factory Score.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Score(
      name: doc.data()!['name'],
      score: doc.data()!['score'],
      timestamp: doc.data()!['timestamp'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        name,
        score,
        timestamp,
      ];
}
