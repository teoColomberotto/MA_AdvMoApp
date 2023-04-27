import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/common_widgets/my_button.dart';

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
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  const AppLogo(),
                  const Spacer(flex: 1),
                  Text(
                    'The Pokemons Quiz',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        onPressed: () =>
                            context.read<HomeBloc>().add(HomePlayPressed()),
                        text: 'PLAY',
                      ),
                      const SizedBox(width: 20),
                      MyButton(
                        onPressed: () => context
                            .read<HomeBloc>()
                            .add(HomeLeaderboardPressed()),
                        text: 'LEADERBOARD',
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }
}
