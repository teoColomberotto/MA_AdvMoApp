import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/enums.dart';
import '../../quizz/bloc/quiz_bloc.dart';
import '../../quizz/bloc/timer_bloc.dart';
import '../../quizz/models/quiz_model.dart';

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;
  static Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizLoaded) {
            quiz = state.quiz;
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(content: Text('Quiz loaded!')));
          } else if (state is QuizTimerRunning) {
            debugPrint('Quiz timer running!${state.duration}');
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
          body: BlocBuilder<TimerBloc, TimerState>(
            builder: (context, timerState) {
              return BlocBuilder<QuizBloc, QuizState>(
                builder: (context, quizState) {
                  if (quizState is QuizLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (quizState is QuizQuestionShown &&
                      quizState.question.status == QuestionStatus.active &&
                      quizState.question.answer == AnswerStatus.unanswered) {
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
                                    quizState.question.pokemonImage.imageData)),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  quizState.question.pokemon.answers.length,
                              itemBuilder: (BuildContext context, int index) {
                                String key = quizState
                                    .question.pokemon.answers.keys
                                    .elementAt(index);
                                String buttonText =
                                    quizState.question.pokemon.answers[key][0];
                                return MaterialButton(
                                  onPressed: () => context.read<QuizBloc>().add(
                                      QuizQuestionAnswered(
                                          currentQuestionIndex:
                                              quizState.currentQuestionIndex,
                                          answerIndex: int.parse(key))),
                                  child: Text(buttonText),
                                );
                              },
                            ),
                          ),
                          //create a timer widget
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(timerState.duration.toString(),
                                style: const TextStyle(fontSize: 24)),
                          ),
                        ],
                      ),
                    );
                  } else if (quizState is QuizQuestionValidated) {
                    if (quizState.question.answer == AnswerStatus.correct &&
                        quizState.currentQuestionIndex <
                            quiz.questions.length - 1) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 256,
                              width: 256,
                              child: Image.memory(
                                  quizState.question.pokemonImage.imageData),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    quizState.question.pokemon.answers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = quizState
                                      .question.pokemon.answers.keys
                                      .elementAt(index);
                                  String buttonText = quizState
                                      .question.pokemon.answers[key][0];
                                  bool answer = quizState
                                      .question.pokemon.answers[key][1];
                                  if (answer) {
                                    return MaterialButton(
                                      disabledColor: Colors.green,
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
                    } else if (quizState.question.answer ==
                            AnswerStatus.incorrect &&
                        quizState.currentQuestionIndex <
                            quiz.questions.length - 1) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 256,
                              width: 256,
                              child: Image.memory(
                                  quizState.question.pokemonImage.imageData),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    quizState.question.pokemon.answers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = quizState
                                      .question.pokemon.answers.keys
                                      .elementAt(index);
                                  String buttonText = quizState
                                      .question.pokemon.answers[key][0];
                                  bool answer = quizState
                                      .question.pokemon.answers[key][1];
                                  if (answer) {
                                    return MaterialButton(
                                      disabledColor: Colors.green,
                                      onPressed: null,
                                      child: Text(buttonText),
                                    );
                                  } else if (quizState
                                          .question.answerChoosedByUser ==
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
                    } else if (quizState.question.answer ==
                            AnswerStatus.correct &&
                        quizState.currentQuestionIndex ==
                            quiz.questions.length - 1) {
                      // print('Turning green');
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 256,
                              width: 256,
                              child: Image.memory(
                                  quizState.question.pokemonImage.imageData),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    quizState.question.pokemon.answers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = quizState
                                      .question.pokemon.answers.keys
                                      .elementAt(index);
                                  String buttonText = quizState
                                      .question.pokemon.answers[key][0];
                                  bool answer = quizState
                                      .question.pokemon.answers[key][1];
                                  if (answer) {
                                    return MaterialButton(
                                      disabledColor: Colors.green,
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
                    } else if (quizState.question.answer ==
                            AnswerStatus.incorrect &&
                        quizState.currentQuestionIndex ==
                            quiz.questions.length - 1) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 256,
                              width: 256,
                              child: Image.memory(
                                  quizState.question.pokemonImage.imageData),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    quizState.question.pokemon.answers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = quizState
                                      .question.pokemon.answers.keys
                                      .elementAt(index);
                                  String buttonText = quizState
                                      .question.pokemon.answers[key][0];
                                  bool answer = quizState
                                      .question.pokemon.answers[key][1];
                                  if (answer) {
                                    return MaterialButton(
                                      disabledColor: Colors.green,
                                      onPressed: null,
                                      child: Text(buttonText),
                                    );
                                  } else if (quizState
                                          .question.answerChoosedByUser ==
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
                                'Error: Question answer status is ${quizState.question.answer}, current question index is ${quizState.currentQuestionIndex}, max question index is ${quiz.questions.length - 1}'),
                          ],
                        ),
                      );
                    }
                  } else if (quizState is QuizFinished) {
                    String scoreName = '';
                    return Center(
                      child: Column(
                        children: [
                          Text(
                              'Correct answers: ${quizState.quiz.correctAnswersCount}'),
                          Text(
                              'Incorrect answers: ${quizState.quiz.wrongAnswersCount}'),
                          Text(
                              'Total questions: ${quizState.quiz.questionsCount}'),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Submit your score if you want'),
                                const SizedBox(height: 8.0),
                                TextField(
                                  onChanged: (String value) =>
                                      {scoreName = value},
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => context
                                          .read<QuizBloc>()
                                          .add(QuizReset()),
                                      child: const Text('Skip'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => context
                                          .read<QuizBloc>()
                                          .add(QuizScoreSubmitted(
                                              scoreName: scoreName)),
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (quizState is QuizError) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Error: ${quizState.message}'),
                        ],
                      ),
                    );
                  } else if (quizState is QuizInitial) {
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
                  } else {
                    return Center(
                      child: Column(
                        children: const [
                          Text('Error: Unknown state'),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ));
  }
}
