import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
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
          backgroundColor: MyColors.mySecondaryColor,
          child: Text(
            score.score.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: MyColors.myBlack),
          ),
        ),
        title: Text(score.name),
        subtitle: Text(formattedData),
        trailing: Text('#$index'),
      ),
    );
  }
}
