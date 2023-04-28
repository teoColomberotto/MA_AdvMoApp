import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quizz/components/score_form.dart';

import '../bloc/quiz_bloc.dart';
import '../components/recap_info.dart';

@RoutePage()
class QuizRecapScreen extends StatelessWidget {
  const QuizRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizFinished) {
              return SafeArea(
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
                            const Spacer(),
                            QuizRecapInfo(quiz: state.quiz),
                            QuizScoreForm(quiz: state.quiz),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              );
            } else {
              return const Center(
                  child: Text('Something went wrong, please try again'));
            }
          },
        ));
  }
}
