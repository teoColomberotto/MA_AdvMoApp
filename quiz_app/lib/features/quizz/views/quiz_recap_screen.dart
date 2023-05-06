import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/features/quizz/components/quiz_recap_logo.dart';
import 'package:quiz_app/features/quizz/components/score_form.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';
import '../bloc/quiz_bloc.dart';
import '../components/recap_info.dart';

@RoutePage()
class QuizRecapScreen extends StatefulWidget {
  const QuizRecapScreen({super.key});

  @override
  State<QuizRecapScreen> createState() => _QuizRecapScreenState();
}

class _QuizRecapScreenState extends State<QuizRecapScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _shouldResetScroll = false;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityController keyboardVisibilityController =
        KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _shouldResetScroll = !visible;
      if (visible == false) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  _buildMobileHorizzontalSliverList(availableWidth, state) {
    return <Widget>[
      SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: (availableWidth / 2) - 50,
                    child: QuizScoreForm(quiz: state.quiz)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                Text('Congratulations !',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: MyColors.mySecondaryColor,
                        )),
                const Spacer(),
                SizedBox(
                    width: (availableWidth / 2) - 80,
                    child: QuizRecapInfo(quiz: state.quiz)),
                const Spacer(),
              ],
            ),
          ),
        ]),
      ),
    ];
  }

  _buildTabletHorizzontalSliverList(availableWidth, state) {
    return <Widget>[
      SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: (availableWidth / 2) - 50,
                    child: QuizScoreForm(quiz: state.quiz)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                Text('Congratulations !',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: MyColors.mySecondaryColor, fontSize: 80)),
                Text('Your score has been saved !',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: MyColors.mySecondaryColor, fontSize: 40)),
                const Spacer(),
                SizedBox(
                    width: (availableWidth / 2) - 50,
                    child: QuizRecapInfo(quiz: state.quiz)),
                const Spacer(),
              ],
            ),
          ),
        ]),
      ),
    ];
  }

  Future<void> _showBackToHomeConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, //user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Your score will not be saved and you will lose your progress.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Back to home',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: MyColors.myBlack),
              ),
              onPressed: () {
                context.read<QuizBloc>().add(QuizReset());
                context.router.popUntilRoot();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return BlocListener<QuizBloc, QuizState>(
        listenWhen: (previous, current) {
          if (current is QuizPausedDueToPausedApplication ||
              current is QuizResumedApplicationDetected) {
            return false;
          } else {
            return true;
          }
        },
        listener: (context, state) {
          if (state is QuizScoreNotValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('A score with $state.scoreName already exists'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
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
              splashRadius: 25.0,
              splashColor: Colors.orangeAccent,
              icon: const Icon(Icons.chevron_left, size: 30),
              onPressed: () {
                _showBackToHomeConfirmationDialog(context);
              },
            ),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            if (myDeviceType == MyDeviceType.mobilePortrait) {
              return _buildMobilePortraitLayout(constraints);
            } else if (myDeviceType == MyDeviceType.mobileLandscape) {
              return _buildMobileLandscapeLayout(constraints);
            } else if (myDeviceType == MyDeviceType.tabletPortrait) {
              return _buildTabletPortraitLayout(constraints);
            } else if (myDeviceType == MyDeviceType.tabletLandscape) {
              return _buildTabletLandscapeLayout(constraints);
            } else {
              return _buildMobilePortraitLayout(constraints);
            }
          }),
        ));
  }

  Widget _buildMobilePortraitLayout(BoxConstraints constraints) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        if (current is QuizScoreNotValid) {
          return false;
        } else if (previous is QuizScoreNotValid && current is QuizFinished) {
          return false;
        } else if (current is QuizPausedDueToPausedApplication ||
            current is QuizResumedApplication ||
            current is QuizPaused ||
            current is QuizResumed) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is QuizFinished) {
          return Container(
            decoration: BoxDecoration(
                gradient: MyColorsGradients.myBackgroundRedGradient),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        Text('Congratulations !',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: MyColors.mySecondaryColor,
                                )),
                        Text(
                          'You have finished the quiz !',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: MyColors.mySecondaryColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(flex: 2),
                        QuizRecapInfo(quiz: state.quiz),
                        const Spacer(flex: 1),
                        QuizScoreForm(quiz: state.quiz),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          );
        } else if (state is QuizScoreValidated) {
          return Container(
            decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient,
            ),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(flex: 1),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: QuizRecapLogo(),
                    ),
                    const Spacer(flex: 1),
                    Text('Thank you ${state.score.name} !',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: MyColors.mySecondaryColor,
                                )),
                    Text('Your score has been saved !',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: MyColors.mySecondaryColor,
                            )),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: MyButton(
                          text: 'Back to home',
                          onPressed: () {
                            context.read<QuizBloc>().add(QuizReset());
                            context.router.popUntilRoot();
                          }),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              )),
            ),
          );
        } else {
          return const Center(
              child: Text('Something went wrong, please try again'));
        }
      },
    );
  }

  Widget _buildMobileLandscapeLayout(BoxConstraints constraints) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        if (current is QuizScoreNotValid) {
          return false;
        } else if (previous is QuizScoreNotValid && current is QuizFinished) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is QuizFinished) {
          return Container(
            decoration: BoxDecoration(
                gradient: MyColorsGradients.myBackgroundRedGradient),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: _buildMobileHorizzontalSliverList(
                      constraints.maxWidth, state),
                ),
              ),
            ),
          );
        } else if (state is QuizScoreValidated) {
          return Container(
            decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient,
            ),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth / 2,
                                maxHeight: constraints.maxHeight * 0.8),
                            child: const QuizRecapLogo(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Spacer(flex: 1),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Thank you \n${state.score.name} !',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: MyColors.mySecondaryColor,
                                  )),
                        ),
                        Text('Your score has been saved !',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: MyColors.mySecondaryColor,
                                    )),
                        const Spacer(flex: 1),
                        MyButton(
                            text: 'Back to home',
                            onPressed: () {
                              context.read<QuizBloc>().add(QuizReset());
                              context.router.popUntilRoot();
                            }),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          );
        } else {
          return const Center(
              child: Text('Something went wrong, please try again'));
        }
      },
    );
  }

  Widget _buildTabletPortraitLayout(BoxConstraints constraints) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        if (current is QuizScoreNotValid) {
          return false;
        } else if (previous is QuizScoreNotValid && current is QuizFinished) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is QuizFinished) {
          return Container(
            decoration: BoxDecoration(
                gradient: MyColorsGradients.myBackgroundRedGradient),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        Text('Congratulations !',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color: MyColors.mySecondaryColor,
                                    fontSize: 80)),
                        Text(
                          'You have finished the quiz !',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: MyColors.mySecondaryColor,
                                  fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(flex: 2),
                        QuizRecapInfo(quiz: state.quiz),
                        const Spacer(flex: 1),
                        QuizScoreForm(quiz: state.quiz),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          );
        } else if (state is QuizScoreValidated) {
          return Container(
            decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient,
            ),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(flex: 1),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: QuizRecapLogo(),
                    ),
                    const Spacer(flex: 1),
                    Text('Thank you ${state.score.name} !',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: MyColors.mySecondaryColor,
                                )),
                    Text('Your score has been saved !',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: MyColors.mySecondaryColor,
                            )),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: MyButton(
                          text: 'Back to home',
                          onPressed: () {
                            context.read<QuizBloc>().add(QuizReset());
                            context.router.popUntilRoot();
                          }),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              )),
            ),
          );
        } else {
          return const Center(
              child: Text('Something went wrong, please try again'));
        }
      },
    );
  }

  Widget _buildTabletLandscapeLayout(BoxConstraints constraints) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) {
        if (current is QuizScoreNotValid) {
          return false;
        } else if (previous is QuizScoreNotValid && current is QuizFinished) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is QuizFinished) {
          return Container(
            decoration: BoxDecoration(
                gradient: MyColorsGradients.myBackgroundRedGradient),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: _buildTabletHorizzontalSliverList(
                      constraints.maxWidth, state),
                ),
              ),
            ),
          );
        } else if (state is QuizScoreValidated) {
          return Container(
            decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient,
            ),
            child: SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth / 2,
                                maxHeight: constraints.maxHeight * 0.8),
                            child: const QuizRecapLogo(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Spacer(flex: 1),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Thank you \n${state.score.name} !',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: MyColors.mySecondaryColor,
                                      fontSize: 80)),
                        ),
                        Text('Your score has been saved !',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: MyColors.mySecondaryColor,
                                    fontSize: 40)),
                        const Spacer(flex: 1),
                        MyButton(
                            text: 'Back to home',
                            onPressed: () {
                              context.read<QuizBloc>().add(QuizReset());
                              context.router.popUntilRoot();
                            }),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          );
        } else {
          return const Center(
              child: Text('Something went wrong, please try again'));
        }
      },
    );
  }
}
