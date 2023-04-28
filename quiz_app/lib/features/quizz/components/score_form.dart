import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';

import '../bloc/quiz_bloc.dart';
import '../models/quiz_model.dart';

class QuizScoreForm extends StatelessWidget {
  final Quiz quiz;
  QuizScoreForm({super.key, required this.quiz});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is QuizInitial) {
          context.router.replaceNamed('/home');
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Insert your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: MyButton(
                  text: 'Skip',
                  onPressed: () => context.read<QuizBloc>().add(QuizReset()),
                )),
                const SizedBox(width: 16),
                Expanded(child: MyButton(text: 'Submit', onPressed: () {})),
              ],
            ),
          ],
        );
      },
    );
  }
}
