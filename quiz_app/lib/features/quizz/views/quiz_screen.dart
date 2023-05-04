import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/features/quizz/components/current_question.dart';
import 'package:quiz_app/features/quizz/components/image_display.dart';
import 'package:quiz_app/features/quizz/components/quiz_actions_background.dart';
import 'package:quiz_app/features/quizz/components/timer_display.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../utils/utils.dart';
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
    return BlocConsumer<QuizBloc, QuizState>(buildWhen: (previous, current) {
      if (current is QuizPaused ||
          current is QuizResumed ||
          current is QuizNavigateToHome ||
          current is QuizPausedDueToNoInternetConnection ||
          current is QuizInternetConnectionRestored ||
          current is QuizPausedDueToPausedApplication ||
          current is QuizResumedApplication) {
        return false;
      } else {
        return true;
      }
    }, builder: (context, state) {
      if (state is QuizLoading) {
        return _mapLoadingStateToUi(context, state);
      } else if (state is QuizError) {
        return _mapErrorStateToUi(context, state);
      } else if (state is QuizFinished) {
        return _mapFinishedStateToUi(context, state);
      } else if (state is QuizQuestionShown) {
        return _mapQuestionShowStateToUi(context, state);
      } else if (state is QuizQuestionValidated) {
        return _mapQuestionValidatedStateToUi(context, state);
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
        context.router.pushNamed('/quiz/recap');
      } else if (state is QuizNavigateToHome) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                      'If you go back to home, the quiz will finish and your current progress will be lost.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.router.popUntilRoot();
                          context.read<QuizBloc>().add(QuizReset());
                        },
                        child: Text(
                          'Go back to home',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: MyColors.myBlack),
                        )),
                    TextButton(
                        onPressed: () {
                          context.router.pop();
                          context.read<QuizBloc>().add(QuizResume());
                        },
                        child: const Text('Cancel')),
                  ],
                ));
      } else if (state is QuizPausedDueToNoInternetConnection) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('No internet connection'),
                  content: const Text(
                      'Please check your internet connection and try again.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.router.popUntilRoot();
                          context.read<QuizBloc>().add(QuizReset());
                        },
                        child: const Text('Go back to home'))
                  ],
                ));
      } else if (state is QuizInternetConnectionRestored) {
        context.router.pop();
        context.read<QuizBloc>().add(QuizResume());
      } else if (state is QuizPausedDueToPausedApplication) {
      } else if (state is QuizResumedApplication) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('App Paused'),
                  content: const Text(
                      'Wlecome back. Feel free to resume you quiz or go back to home.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.router.pop();
                          context.read<QuizBloc>().add(QuizResume());
                        },
                        child: const Text('Resume quiz')),
                    TextButton(
                        onPressed: () {
                          context.router.popUntilRoot();
                          context.read<QuizBloc>().add(QuizReset());
                        },
                        child: const Text('Go back to home'))
                  ],
                ));
      }
    });
  }

  Widget _mapLoadingStateToUi(BuildContext context, QuizLoading state) {
    final Color backgroundColor = MyColors.myBackgroundColor;
    final Color backIconColor = getFontColorForBackground(backgroundColor);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/pokemonBrand-logo.png',
          fit: BoxFit.contain,
          height: 32,
        ),
        leading: IconButton(
          color: backIconColor,
          splashRadius: 25.0,
          splashColor: MyColors.myOrangeAccent,
          icon: const Icon(Icons.chevron_left, size: 30),
          onPressed: () {
            context.read<QuizBloc>().add(QuizBackToHome());
          },
        ),
      ),
      body: Container(
        decoration:
            BoxDecoration(gradient: MyColorsGradients.myBackgroundRedGradient),
        child: SafeArea(
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
                Text(state.message, style: TextStyle(color: MyColors.myWhite)),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
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
            Icon(
              Icons.error,
              color: MyColors.myErrorColor,
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

  Widget _mapQuestionShowStateToUi(
      BuildContext context, QuizQuestionShown state) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        final PokemonType pokemonType = _quiz.currentQuestion.pokemon.type;
        final Color backgroundColor =
            mapBackgroundColorToPokemonType(pokemonType);
        final Color backIconColor = getFontColorForBackground(backgroundColor);
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.myBackgroundColor,
              elevation: 0,
              title: Image.asset(
                'assets/images/pokemonBrand-logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              leading: IconButton(
                color: backIconColor,
                splashRadius: 25.0,
                splashColor: MyColors.myOrangeAccent,
                icon: const Icon(Icons.chevron_left, size: 30),
                onPressed: () {
                  context.read<QuizBloc>().add(QuizBackToHome());
                },
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: MyColorsGradients.myBackgroundRedGradient),
              child: SafeArea(
                child: Center(
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        MyQuizActionsBackground(
                          backgroundColor: MyColors.myWhite,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(alignment: Alignment.center, children: [
                            Column(children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: MyPokemonImage(
                                    imageData: _quiz
                                        .currentQuestion.pokemonImage.imageData,
                                    show: false),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              MyQuestionDisplay(
                                  question: _quiz.currentQuestion),
                            ]),
                            Positioned(
                                bottom: 100,
                                child: MyCurrentQuestionDisplay(quiz: _quiz)),
                            Positioned(
                                bottom: 20,
                                child: MyTimerDisplay(
                                  timeRemaining: timerState.duration,
                                  background: backgroundColor,
                                )),
                          ]),
                        ),
                      ]),
                ),
              ),
            ));
      },
    );
  }

  Widget _mapQuestionValidatedStateToUi(
      BuildContext context, QuizQuestionValidated state) {
    final PokemonType pokemonType = _quiz.currentQuestion.pokemon.type;
    final Color backgroundColor = mapBackgroundColorToPokemonType(pokemonType);
    final Color backIconColor = getFontColorForBackground(backgroundColor);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: mapBackgroundColorToPokemonType(
              _quiz.currentQuestion.pokemon.type),
          elevation: 0,
          title: Image.asset(
            'assets/images/pokemonBrand-logo.png',
            fit: BoxFit.contain,
            height: 32,
          ),
          leading: IconButton(
            color: backIconColor,
            splashRadius: 25.0,
            splashColor: Colors.orangeAccent,
            icon: const Icon(Icons.chevron_left, size: 30),
            onPressed: () {
              context.read<QuizBloc>().add(QuizBackToHome());
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: mapBackgroundColorToPokemonType(
                _quiz.currentQuestion.pokemon.type),
          ),
          child: SafeArea(
            child: Center(
              child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    MyQuizActionsBackground(
                      backgroundColor: MyColors.myWhite,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(alignment: Alignment.center, children: [
                        Column(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: MyPokemonImage(
                                imageData: _quiz
                                    .currentQuestion.pokemonImage.imageData,
                                show: true),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          MyQuestionDisplay(question: _quiz.currentQuestion),
                        ]),
                        Positioned(
                            bottom: 100,
                            child: MyCurrentQuestionDisplay(quiz: _quiz)),
                        Positioned(
                            bottom: 20,
                            child: MyButton(
                              backgroundColor: Colors.white,
                              text: _quiz.currentQuestionIndex <
                                      _quiz.questionsCount - 1
                                  ? 'Next Question'
                                  : 'Finish Quiz',
                              onPressed: () => _quiz.currentQuestionIndex <
                                      _quiz.questionsCount - 1
                                  ? context
                                      .read<QuizBloc>()
                                      .add(QuizIncrementCurrentQuestion())
                                  : context.read<QuizBloc>().add(QuizFinish()),
                            ))
                      ]),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget _mapScoreDisplayedStateToUi(BuildContext context) {
    return const Center();
  }

  Widget _mapPokemonImageDisplayedStateToUi(BuildContext context) {
    return const Center();
  }
}
