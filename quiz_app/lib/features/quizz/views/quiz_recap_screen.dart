import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';
import '../components/recap_info.dart';

@RoutePage()
class QuizRecapScreen extends StatelessWidget {
  const QuizRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizFinished) {
              return SafeArea(
                child: Center(child: QuizRecapInfo(quiz: state.quiz)),
              );
            } else {
              return const Center(
                  child: Text('Something went wrong, please try again'));
            }
          },
        ));
  }
}
