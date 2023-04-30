import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/features/quizz/components/score_form.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
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
          body: BlocBuilder<QuizBloc, QuizState>(
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
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(flex: 1),
                            Text('Congratulations !',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: MyColors.mySecondaryColor,
                                    )),
                            const Spacer(flex: 1),
                            QuizRecapInfo(quiz: state.quiz),
                            const Spacer(flex: 1),
                            QuizScoreForm(quiz: state.quiz),
                            const Spacer(flex: 3),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            );
          } else if (state is QuizScoreValidated) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, Colors.deepOrange],
                ),
              ),
              child: SafeArea(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(flex: 2),
                      Text('Thank you ${state.score.name} !',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: MyColors.mySecondaryColor,
                              )),
                      Text('Your score has been saved !',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                      const Spacer(flex: 3),
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
      )),
    );
  }
}
