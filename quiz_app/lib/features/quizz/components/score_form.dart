import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';

import '../bloc/quiz_bloc.dart';
import '../models/quiz_model.dart';

class QuizScoreForm extends StatefulWidget {
  final Quiz quiz;
  const QuizScoreForm({super.key, required this.quiz});

  @override
  State<QuizScoreForm> createState() => _QuizScoreFormState();
}

class _QuizScoreFormState extends State<QuizScoreForm> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is QuizInitial) {
          context.router.popUntilRoot();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
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
                  Expanded(
                      child: MyButton(
                          text: 'Submit',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<QuizBloc>().add(QuizScoreSubmitted(
                                  scoreName: nameController.text.isEmpty
                                      ? 'Anonymous'
                                      : nameController.text));
                            }
                          })),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
