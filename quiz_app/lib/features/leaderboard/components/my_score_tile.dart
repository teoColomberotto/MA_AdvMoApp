import 'package:flutter/material.dart';

import '../../database/models/score_model.dart';

class MyScoreTile extends StatelessWidget {
  final Score score;
  final int index;

  const MyScoreTile({Key? key, required this.score, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(score.score.toString()),
        ),
        title: Text(score.name),
        subtitle: Text(score.timestamp.toString()),
        trailing: Text('#$index'),
      ),
    );
  }
}
