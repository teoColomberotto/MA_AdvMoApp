import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';

import '../../../constants/colors.dart';
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
              Text('Submit your score',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: MyColors.mySecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.myTertiaryColor,
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    labelText: 'Insert your name',
                    errorStyle: TextStyle(color: MyColors.myBlack),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    errorBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: MyButton(
                    backgroundColor: MyColors.myBlack,
                    textColor: MyColors.myWhite,
                    text: 'Skip',
                    onPressed: () => context.read<QuizBloc>().add(QuizReset()),
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: MyButton(
                          text: 'Submit',
                          backgroundColor: MyColors.myTertiaryColor,
                          textColor: MyColors.myOnTertiaryColor,
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
