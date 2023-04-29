import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/score_model.dart';

class MyScoreTile extends StatelessWidget {
  final Score score;
  final int index;
  late final String formattedData;
  MyScoreTile({Key? key, required this.score, required this.index})
      : super(key: key) {
    formattedData = DateFormat('d MMMM y').format(score.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(score.score.toString()),
        ),
        title: Text(score.name),
        subtitle: Text(formattedData),
        trailing: Text('#$index'),
      ),
    );
  }
}
