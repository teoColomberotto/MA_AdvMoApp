import 'package:flutter/material.dart';
import 'package:quiz_app/features/play_settings/components/difficulty_tile.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';

class DifficultyPicker extends StatefulWidget {
  final Difficulty selectedDifficulty;
  final Function(Difficulty) onDifficultyChanged;

  const DifficultyPicker(
      {Key? key,
      required this.selectedDifficulty,
      required this.onDifficultyChanged})
      : super(key: key);

  @override
  _DifficultyPickerState createState() =>
      _DifficultyPickerState(selectedDifficulty, onDifficultyChanged);
}

class _DifficultyPickerState extends State<DifficultyPicker> {
  Difficulty selectedDifficulty;
  final void Function(Difficulty) onDifficultyChanged;

  _DifficultyPickerState(this.selectedDifficulty, this.onDifficultyChanged);

  @override
  Widget build(BuildContext context) {
    int nrCount = Difficulty.values.length;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: nrCount,
      itemBuilder: (context, index) {
        return DifficultyTile(
          difficulty: Difficulty.values[index],
          selected: selectedDifficulty,
          onTap: () {
            onDifficultyChanged(Difficulty.values[index]);
            setState(() {
              selectedDifficulty = Difficulty.values[index];
            });
          },
        );
      },
    );
  }
}
