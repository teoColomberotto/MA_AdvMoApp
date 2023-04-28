import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/leaderboard_bloc.dart';

@RoutePage()
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red, Colors.deepOrange],
            ),
          ),
          child: SafeArea(
            child: Center(
                child: Column(
              children: [],
            )),
          ),
        ),
      ),
    );
  }
}
