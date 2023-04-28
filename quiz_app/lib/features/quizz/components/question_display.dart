import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/enums.dart';

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
        children: List.generate((answersCount / 2).ceil(), (index) {
          final rowIndex = index * 2;
          String key_1 = question.pokemon.answers.keys.elementAt(rowIndex);
          String key_2 = question.pokemon.answers.keys.elementAt(rowIndex + 1);
          final answer1 =
              answersCount > rowIndex ? question.pokemon.answers[key_1] : null;
          final answer2 = answersCount > rowIndex + 1
              ? question.pokemon.answers[key_2]
              : null;
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer1[0],
                backgroundColor: Colors.blue,
                onPressed: () => context.read<QuizBloc>().add(
                    QuizQuestionAnswered(
                        currentQuestionIndex: quizState.currentQuestionIndex,
                        answerIndex: int.parse(key_1))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer2[0],
                backgroundColor: Colors.blue,
                onPressed: () => context.read<QuizBloc>().add(
                    QuizQuestionAnswered(
                        currentQuestionIndex: quizState.currentQuestionIndex,
                        answerIndex: int.parse(key_2))),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _createCorrectButtonsList() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate((answersCount / 2).ceil(), (index) {
          final rowIndex = index * 2;
          String key_1 = question.pokemon.answers.keys.elementAt(rowIndex);
          String key_2 = question.pokemon.answers.keys.elementAt(rowIndex + 1);
          final answer1 =
              answersCount > rowIndex ? question.pokemon.answers[key_1] : null;
          final answer2 = answersCount > rowIndex + 1
              ? question.pokemon.answers[key_2]
              : null;
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer1[0],
                backgroundColor:
                    int.parse(key_1) == question.answerChoosedByUser
                        ? Colors.green
                        : Colors.blue,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer2[0],
                backgroundColor:
                    int.parse(key_2) == question.answerChoosedByUser
                        ? Colors.green
                        : Colors.blue,
                onPressed: () {},
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _createIncorrectButtonsList() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate((answersCount / 2).ceil(), (index) {
          final rowIndex = index * 2;
          String key_1 = question.pokemon.answers.keys.elementAt(rowIndex);
          String key_2 = question.pokemon.answers.keys.elementAt(rowIndex + 1);
          final answer1 =
              answersCount > rowIndex ? question.pokemon.answers[key_1] : null;
          final answer2 = answersCount > rowIndex + 1
              ? question.pokemon.answers[key_2]
              : null;
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer1[0],
                backgroundColor:
                    int.parse(key_1) == question.answerChoosedByUser
                        ? Colors.red
                        : question.pokemon.answers[key_1][1] == true
                            ? Colors.green
                            : Colors.blue,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MyButton(
                text: answer2[0],
                backgroundColor:
                    int.parse(key_2) == question.answerChoosedByUser
                        ? Colors.red
                        : question.pokemon.answers[key_2][1] == true
                            ? Colors.green
                            : Colors.blue,
                onPressed: () {},
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
