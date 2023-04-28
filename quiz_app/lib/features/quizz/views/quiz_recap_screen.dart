import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/features/quizz/components/score_form.dart';

import '../bloc/quiz_bloc.dart';
import '../components/recap_info.dart';

@RoutePage()
class QuizRecapScreen extends StatelessWidget {
  const QuizRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is QuizScoreNotValid) {
          // context.read<QuizBloc>().add(QuizFinish());
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
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(flex: 2),
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
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(flex: 2),
                            const Text(
                                'Congratulations, your score has been saved !'),
                            const Spacer(flex: 1),
                            MyButton(
                                text: 'Back to home',
                                onPressed: () {
                                  context.read<QuizBloc>().add(QuizReset());
                                  context.router.popUntilRoot();
                                }),
                            const Spacer(flex: 3),
                          ],
                        ),
                      ),
                    ),
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
