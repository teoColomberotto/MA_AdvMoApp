import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/enums.dart';
import '../../quizz/bloc/quiz_bloc.dart';
import '../../quizz/models/quiz_model.dart';

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;
  static Quiz quiz = Quiz(questions: []);

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizLoaded) {
            quiz = state.quiz;
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(content: Text('Quiz loaded!')));
          }
          // } else if (state is QuizQuestionShown) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('Quiz question shown!')));
          // } else if (state is QuizPokemonImageDisplayed) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('Quiz pokemon image displayed!')));
          // } else if (state is QuizError) {
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(const SnackBar(content: Text('Quiz error!')));
          // }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is QuizQuestionShown &&
                  state.question.status == QuestionStatus.active &&
                  state.question.answer == AnswerStatus.unanswered) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 256,
                        width: 256,
                        child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                            child: Image.memory(
                                state.question.pokemonImage.imageData)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.question.pokemon.answers.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = state.question.pokemon.answers.keys
                                .elementAt(index);
                            String buttonText =
                                state.question.pokemon.answers[key][0];
                            return MaterialButton(
                              onPressed: () => context.read<QuizBloc>().add(
                                  QuizQuestionAnswered(
                                      currentQuestionIndex:
                                          state.currentQuestionIndex,
                                      answerIndex: int.parse(key))),
                              child: Text(buttonText),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is QuizQuestionValidated) {
                if (state.question.answer == AnswerStatus.correct &&
                    state.currentQuestionIndex < quiz.questions.length - 1) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 256,
                          width: 256,
                          child: Image.memory(
                              state.question.pokemonImage.imageData),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.question.pokemon.answers.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = state.question.pokemon.answers.keys
                                  .elementAt(index);
                              String buttonText =
                                  state.question.pokemon.answers[key][0];
                              bool answer =
                                  state.question.pokemon.answers[key][1];
                              if (answer) {
                                return MaterialButton(
                                  color: Colors.green,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else {
                                return MaterialButton(
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              }
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () => context
                              .read<QuizBloc>()
                              .add(QuizIncrementCurrentQuestion()),
                          child: const Text('NEXT QUESTION'),
                        ),
                      ],
                    ),
                  );
                } else if (state.question.answer == AnswerStatus.incorrect &&
                    state.currentQuestionIndex < quiz.questions.length - 1) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 256,
                          width: 256,
                          child: Image.memory(
                              state.question.pokemonImage.imageData),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.question.pokemon.answers.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = state.question.pokemon.answers.keys
                                  .elementAt(index);
                              String buttonText =
                                  state.question.pokemon.answers[key][0];
                              bool answer =
                                  state.question.pokemon.answers[key][1];
                              if (answer) {
                                return MaterialButton(
                                  disabledColor: Colors.green,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else if (state.question.answerChoosedByUser ==
                                  int.parse(key)) {
                                return MaterialButton(
                                  disabledColor: Colors.red,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else {
                                return MaterialButton(
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              }
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () => context
                              .read<QuizBloc>()
                              .add(QuizIncrementCurrentQuestion()),
                          child: const Text('NEXT QUESTION'),
                        ),
                      ],
                    ),
                  );
                } else if (state.question.answer == AnswerStatus.correct &&
                    state.currentQuestionIndex == quiz.questions.length - 1) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 256,
                          width: 256,
                          child: Image.memory(
                              state.question.pokemonImage.imageData),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.question.pokemon.answers.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = state.question.pokemon.answers.keys
                                  .elementAt(index);
                              String buttonText =
                                  state.question.pokemon.answers[key][0];
                              bool answer =
                                  state.question.pokemon.answers[key][1];
                              if (answer) {
                                return MaterialButton(
                                  color: Colors.green,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else {
                                return MaterialButton(
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              }
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () =>
                              context.read<QuizBloc>().add(QuizFinish()),
                          child: const Text('FINISH QUESTION'),
                        ),
                      ],
                    ),
                  );
                } else if (state.question.answer == AnswerStatus.incorrect &&
                    state.currentQuestionIndex == quiz.questions.length - 1) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 256,
                          width: 256,
                          child: Image.memory(
                              state.question.pokemonImage.imageData),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.question.pokemon.answers.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = state.question.pokemon.answers.keys
                                  .elementAt(index);
                              String buttonText =
                                  state.question.pokemon.answers[key][0];
                              bool answer =
                                  state.question.pokemon.answers[key][1];
                              if (answer) {
                                return MaterialButton(
                                  disabledColor: Colors.green,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else if (state.question.answerChoosedByUser ==
                                  int.parse(key)) {
                                return MaterialButton(
                                  disabledColor: Colors.red,
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              } else {
                                return MaterialButton(
                                  onPressed: null,
                                  child: Text(buttonText),
                                );
                              }
                            },
                          ),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () =>
                              context.read<QuizBloc>().add(QuizFinish()),
                          child: const Text('FINISH QUIZ'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                            'Error: Question answer status is ${state.question.answer}, current question index is ${state.currentQuestionIndex}, max question index is ${quiz.questions.length - 1}'),
                      ],
                    ),
                  );
                }
              } else if (state is QuizFinished) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                          'Correct answers: ${state.quiz.correctAnswersCount}'),
                      Text(
                          'Incorrect answers: ${state.quiz.wrongAnswersCount}'),
                      Text('Total questions: ${state.quiz.questionsCount}'),
                    ],
                  ),
                );
              } else if (state is QuizError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Error: ${state.message}'),
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () =>
                          context.read<QuizBloc>().add(QuizStart()),
                      child: const Text('Start quiz'),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
