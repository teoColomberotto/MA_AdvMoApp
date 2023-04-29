import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/enums.dart';

import '../../../constants/colors.dart';
import '../bloc/quiz_bloc.dart';
import '../models/question_model.dart';

class MyQuestionDisplay extends StatelessWidget {
  final Question question;
  final int answersCount;
  MyQuestionDisplay({super.key, required this.question})
      : answersCount = question.pokemon.answers.length;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(buildWhen: (previous, current) {
      if (current is QuizPaused ||
          current is QuizResumed ||
          current is QuizNavigateToHome) {
        return false;
      } else {
        return true;
      }
    }, builder: (context, quizState) {
      if (quizState is QuizQuestionShown) {
        return _createInitialButtonsList(context, quizState);
      } else if (quizState is QuizQuestionValidated) {
        switch (quizState.question.answer) {
          case AnswerStatus.unanswered:
            return _createInitialButtonsList(context, quizState);
          case AnswerStatus.correct:
            return _createCorrectButtonsList();
          case AnswerStatus.incorrect:
            return _createIncorrectButtonsList();
        }
      } else {
        return const Center(
            child: Text('Something went wrong, please try again'));
      }
    });
  }

  Widget _createInitialButtonsList(BuildContext context, quizState) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        childAspectRatio: 2.0,
        children: List.generate((answersCount), (index) {
          String key = question.pokemon.answers.keys.elementAt(index);
          final answer =
              answersCount > index ? question.pokemon.answers[key] : null;
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: MyButton(
              text: answer[0],
              backgroundColor: MyColors.myWhite,
              textColor: MyColors.myOnTertiaryColor,
              onPressed: () => context.read<QuizBloc>().add(
                  QuizQuestionAnswered(
                      currentQuestionIndex: quizState.currentQuestionIndex,
                      answerIndex: int.parse(key))),
            ),
          );
        }),
      ),
    );
  }

  Widget _createCorrectButtonsList() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        childAspectRatio: 2.0,
        children: List.generate((answersCount), (index) {
          String key = question.pokemon.answers.keys.elementAt(index);
          final answer =
              answersCount > index ? question.pokemon.answers[key] : null;
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: MyButton(
              text: answer[0],
              backgroundColor: int.parse(key) == question.answerChoosedByUser
                  ? Colors.green
                  : MyColors.myWhite,
              textColor: int.parse(key) == question.answerChoosedByUser
                  ? MyColors.myBlack
                  : MyColors.myBlack,
              onPressed: () {},
            ),
          );
        }),
      ),
    );
  }

  Widget _createIncorrectButtonsList() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        childAspectRatio: 2.0,
        children: List.generate((answersCount), (index) {
          String key = question.pokemon.answers.keys.elementAt(index);
          final answer =
              answersCount > index ? question.pokemon.answers[key] : null;
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: MyButton(
              text: answer[0],
              backgroundColor: int.parse(key) == question.answerChoosedByUser
                  ? Colors.red
                  : question.pokemon.answers[key][1] == true
                      ? Colors.green
                      : MyColors.myWhite,
              textColor: int.parse(key) == question.answerChoosedByUser
                  ? MyColors.myWhite
                  : question.pokemon.answers[key][1] == true
                      ? MyColors.myBlack
                      : MyColors.myBlack,
              onPressed: () {},
            ),
          );
        }),
      ),
    );
  }
}
