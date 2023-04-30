import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/features/home/components/home_title.dart';

import '../bloc/bloc/home_bloc.dart';
import '../components/app_logo.dart';
import '../../quizz/models/quiz_model.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, title}) : title = title ?? 'Home Screen';
  final String title;
  static Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomePlayButtonPressed) {
            context.router.pushNamed('/quiz');
            context.read<HomeBloc>().add(HomeResetState());
          } else if (state is HomeLeaderboardButtonPressed) {
            context.router.pushNamed('/leaderboard');
            context.read<HomeBloc>().add(HomeResetState());
          } else if (state is HomeAboutButtonPressed) {
            context.router.pushNamed('/about');
            context.read<HomeBloc>().add(HomeResetState());
          } else if (state is HomeQuizStartRefused) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 4),
              ),
            );
            context.read<HomeBloc>().add(HomeResetState());
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
            actions: [
              IconButton(
                splashRadius: 25.0,
                color: MyColors.myTertiaryColor,
                splashColor: MyColors.myOrangeAccent,
                icon: const Icon(Icons.help, size: 30),
                onPressed: () {
                  context.read<HomeBloc>().add(HomeAboutPressed());
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: MyColorsGradients.myBackgroundRedGradient,
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    const MyAppTitle(),
                    const Spacer(flex: 2),
                    const AppLogo(),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            onPressed: () =>
                                context.read<HomeBloc>().add(HomePlayPressed()),
                            text: 'PLAY',
                            backgroundColor: MyColors.myTertiaryColor,
                            textColor: MyColors.myOnTertiaryColor,
                          ),
                          const SizedBox(width: 20),
                          MyButton(
                            onPressed: () => context
                                .read<HomeBloc>()
                                .add(HomeLeaderboardPressed()),
                            text: 'LEADERBOARD',
                            textColor: MyColors.myWhite,
                            backgroundColor: MyColors.myBlack,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
