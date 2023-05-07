// ignore_for_file: library_private_types_in_public_api

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/breakpoints.dart';
import 'package:quiz_app/constants/enums.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quiz_app/features/play_settings/components/difficulty_picker.dart';
import 'package:quiz_app/features/play_settings/components/play_settings_title.dart';
import 'package:quiz_app/utils/utils.dart';

import '../../../constants/colors.dart';
import '../../quizz/bloc/quiz_bloc.dart';
import '../bloc/play_settings_bloc.dart';

@RoutePage()
class PlaySettingsScreen extends StatefulWidget {
  const PlaySettingsScreen({super.key});

  @override
  _PlaySettingsScreenState createState() => _PlaySettingsScreenState();
}

class _PlaySettingsScreenState extends State<PlaySettingsScreen> {
  Difficulty _selectedDifficulty = Difficulty.medium;
  int _selectedQuestionsNumber = 10;

  void _submitForm(BuildContext context) {
    context.read<PlaySettingsBloc>().add(PlaySettingsSubmitted(
        difficulty: _selectedDifficulty,
        numberOfQuestions: _selectedQuestionsNumber));
  }

  void _handleDifficultyChanged(Difficulty difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return BlocListener<PlaySettingsBloc, PlaySettingsState>(
      listener: (BuildContext context, state) {
        if (state is PlaySettingsValidated) {
          context
              .read<QuizBloc>()
              .add(QuizStart(playSettings: state.playSettings));
          context.router.pushNamed('/quiz');
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
                context.router.pop();
              },
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (myDeviceType == MyDeviceType.mobilePortrait) {
                return _buildMobilePortraitLayout(context);
              } else if (myDeviceType == MyDeviceType.mobileLandscape) {
                return _buildMobileLandscapeLayout(context);
              } else if (myDeviceType == MyDeviceType.tabletPortrait) {
                return _buildTabletPortraitLayout(context);
              } else if (myDeviceType == MyDeviceType.tabletLandscape) {
                return _buildTabletLandscapeLayout(context);
              } else {
                return _buildMobilePortraitLayout(context);
              }
            },
          )),
    );
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
    return BlocBuilder<PlaySettingsBloc, PlaySettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const Spacer(),
                    const MyPlaySettingsTitle(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Difficulty:',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: MyColors.myTertiaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 120,
                              maxWidth: MediaQuery.of(context).size.width - 40),
                          child: DifficultyPicker(
                              selectedDifficulty: _selectedDifficulty,
                              onDifficultyChanged: _handleDifficultyChanged),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Number of Questions:',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: MyColors.myTertiaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    NumberPicker(
                        value: _selectedQuestionsNumber,
                        minValue: 5,
                        maxValue: 20,
                        step: 5,
                        itemHeight: 100,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _selectedQuestionsNumber = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: MyColors.myTertiaryColor),
                        ),
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: MyColors.myTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                )),
                    const Spacer(),
                    MyButton(
                      text: 'START',
                      onPressed: () => _submitForm(context),
                      backgroundColor: MyColors.myTertiaryColor,
                      textColor: MyColors.myOnTertiaryColor,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLandscapeLayout(BuildContext context) {
    return BlocBuilder<PlaySettingsBloc, PlaySettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const MyPlaySettingsTitle(),
                        const Spacer(),
                        MyButton(
                          text: 'START',
                          onPressed: () => _submitForm(context),
                          backgroundColor: MyColors.myTertiaryColor,
                          textColor: MyColors.myOnTertiaryColor,
                        ),
                        const Spacer(),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 120,
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 40),
                                child: DifficultyPicker(
                                    selectedDifficulty: _selectedDifficulty,
                                    onDifficultyChanged:
                                        _handleDifficultyChanged),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          NumberPicker(
                              value: _selectedQuestionsNumber,
                              minValue: 5,
                              maxValue: 20,
                              step: 5,
                              itemHeight: 100,
                              axis: Axis.horizontal,
                              onChanged: (value) => setState(
                                  () => _selectedQuestionsNumber = value),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: MyColors.myTertiaryColor),
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: MyColors.myTertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Number of questions',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: MyColors.myTertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return BlocBuilder<PlaySettingsBloc, PlaySettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const Spacer(),
                    const MyPlaySettingsTitle(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Difficulty:',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: MyColors.myTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 220,
                              maxWidth: MediaQuery.of(context).size.width - 40),
                          child: DifficultyPicker(
                              selectedDifficulty: _selectedDifficulty,
                              onDifficultyChanged: _handleDifficultyChanged),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Number of Questions:',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: MyColors.myTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    NumberPicker(
                        value: _selectedQuestionsNumber,
                        minValue: 5,
                        maxValue: 20,
                        step: 5,
                        itemHeight: 100,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _selectedQuestionsNumber = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: MyColors.myTertiaryColor),
                        ),
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: MyColors.myTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 300),
                      child: MyButton(
                        text: 'START',
                        onPressed: () => _submitForm(context),
                        backgroundColor: MyColors.myTertiaryColor,
                        textColor: MyColors.myOnTertiaryColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return BlocBuilder<PlaySettingsBloc, PlaySettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Spacer(),
                        const MyPlaySettingsTitle(),
                        const Spacer(),
                        MyButton(
                          text: 'START',
                          onPressed: () => _submitForm(context),
                          backgroundColor: MyColors.myTertiaryColor,
                          textColor: MyColors.myOnTertiaryColor,
                        ),
                        const Spacer(),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 220,
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 40),
                                child: DifficultyPicker(
                                    selectedDifficulty: _selectedDifficulty,
                                    onDifficultyChanged:
                                        _handleDifficultyChanged),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Difficulty',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: MyColors.myTertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          NumberPicker(
                              value: _selectedQuestionsNumber,
                              minValue: 5,
                              maxValue: 20,
                              step: 5,
                              itemHeight: 100,
                              axis: Axis.horizontal,
                              onChanged: (value) => setState(
                                  () => _selectedQuestionsNumber = value),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: MyColors.myTertiaryColor),
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: MyColors.myTertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Number of questions',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: MyColors.myTertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
