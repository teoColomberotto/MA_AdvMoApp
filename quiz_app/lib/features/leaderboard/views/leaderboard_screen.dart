import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/leaderboard/components/leaderboard_title.dart';

import '../bloc/leaderboard_bloc.dart';
import '../components/leaderboard_display.dart';

@RoutePage()
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaderboardBloc>().add(const LeaderboardLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaderboardBloc, LeaderboardState>(
      listener: (context, state) {
        if (state is LeaderboardHomeButtonPressed) {
          context.router.pop();
          context.read<LeaderboardBloc>().add(LeaderboardHomePressed());
          context.read<LeaderboardBloc>().add(LeaderboardResetState());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
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
              context.read<LeaderboardBloc>().add(LeaderboardHomePressed());
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.deepOrange],
              ),
            ),
            child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
              builder: (context, state) {
                if (state is LeaderboardDisplayed) {
                  return Center(
                    child: Column(children: [
                      const Spacer(flex: 1),
                      const MyLeaderboardTitle(),
                      const Spacer(flex: 1),
                      SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Expanded(
                              child: MyLeaderboardDisplay(
                                  leaderboard: state.leaderboard)),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ]),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
