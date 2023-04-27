import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/features/quizz/components/current_question.dart';
import 'package:quiz_app/features/quizz/components/image_display.dart';
import 'package:quiz_app/features/quizz/components/timer_display.dart';

import '../bloc/quiz_bloc.dart';
import '../bloc/timer_bloc.dart';
import '../components/question_display.dart';
import '../models/quiz_model.dart';

@RoutePage()
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  static Quiz _quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<QuizBloc, QuizState>(builder: (context, state) {
      if (state is QuizLoading) {
        return _mapLoadingStateToUi(context, state);
      } else if (state is QuizError) {
        return _mapErrorStateToUi(context, state);
      } else if (state is QuizFinished) {
        return _mapFinishedStateToUi(context, state);
      } else if (state is QuizQuestionShown) {
        return _mapQuestionShowStateToUi(context);
      } else if (state is QuizQuestionValidated) {
        return _mapQuestionValidatedStateToUi(context);
      } else if (state is QuizScoreDisplayed) {
        return _mapScoreDisplayedStateToUi(context);
      } else if (state is QuizPokemonImageDisplayed) {
        return _mapPokemonImageDisplayedStateToUi(context);
      } else if (state is QuizFinished) {
        return _mapFinishedStateToUi(context, state);
      } else {
        return const Center(
            child: Text('Something went wrong, please try again'));
      }
    }, listener: (context, state) {
      if (state is QuizLoaded) {
        _quiz = state.quiz;
      } else if (state is QuizTimerRunning) {
        debugPrint('Quiz timer running!${state.duration}');
      } else if (state is QuizFinished) {
        //navigate to quiz recap
        context.router.pushNamed('/quiz/recap');
      }
    }));
  }

  Widget _mapLoadingStateToUi(BuildContext context, QuizLoading state) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            const CircularProgressIndicator(),
            const Spacer(
              flex: 1,
            ),
            Text(state.message),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _mapErrorStateToUi(BuildContext context, QuizError state) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            Text(state.message),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapFinishedStateToUi(BuildContext context, QuizFinished state) {
    return const Center();
  }

  Widget _mapQuestionShowStateToUi(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        return SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                    top: 20, child: MyCurrentQuestionDisplay(quiz: _quiz)),
                Column(children: [
                  const Spacer(flex: 1),
                  MyPokemonImage(
                      imageData: _quiz.currentQuestion.pokemonImage.imageData,
                      show: false),
                  const Spacer(flex: 1),
                  MyQuestionDisplay(question: _quiz.currentQuestion),
                  const Spacer(flex: 1),
                ]),
                Positioned(
                    bottom: 20,
                    child: MyTimerDisplay(timeRemaining: timerState.duration)),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _mapQuestionValidatedStateToUi(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(top: 20, child: MyCurrentQuestionDisplay(quiz: _quiz)),
            Column(children: [
              const Spacer(flex: 1),
              MyPokemonImage(
                  imageData: _quiz.currentQuestion.pokemonImage.imageData,
                  show: true),
              const Spacer(flex: 1),
              MyQuestionDisplay(question: _quiz.currentQuestion),
              const Spacer(flex: 1),
            ]),
            Positioned(
                bottom: 20,
                child: MyButton(
                  text: _quiz.currentQuestionIndex < _quiz.questionsCount - 1
                      ? 'Next Question'
                      : 'Finish Quiz',
                  onPressed: () =>
                      _quiz.currentQuestionIndex < _quiz.questionsCount - 1
                          ? context
                              .read<QuizBloc>()
                              .add(QuizIncrementCurrentQuestion())
                          : context.read<QuizBloc>().add(QuizFinish()),
                ))
          ]),
        ),
      ),
    );
  }

  Widget _mapScoreDisplayedStateToUi(BuildContext context) {
    return const Center();
  }

  Widget _mapPokemonImageDisplayedStateToUi(BuildContext context) {
    return const Center();
  }
}
