import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/database/models/leaderboard_model.dart';

import '../../database/bloc/database_bloc.dart';
import '../../database/models/score_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  static List<String> pokemons = [];
  static Leaderboard leaderboard = Leaderboard(leaderboard: const []);
  static Score score =
      Score(score: 150, name: "testname", timestamp: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listener: (context, state) {
        if (state is DatabasePokemonsListLoaded) {
          pokemons = state.pokemons.map((e) => e.name).toList();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pokemons list loaded!')));
        } else if (state is DatabaseInitial) {
          context
              .read<DatabaseBloc>()
              .add(const DatabaseGetPokemonsList(limit: 15));
        } else if (state is DatabasePokemonImageLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pokemon image loaded!')));
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("pokemon image"),
                  content: Image.memory(state.imageData.imageData),
                );
              });
        } else if (state is DatabaseLeaderboardLoaded) {
          leaderboard = state.leaderboard;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Leaderboard loaded!')));
        } else if (state is DatabaseScoreAdded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Score added!')));
        } else if (state is DatabaseScoreNameAlreadyExists) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Score name already exists! Try another one.')));
        } else if (state is DatabaseError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () => context
                      .read<DatabaseBloc>()
                      .add(const DatabaseGetLeaderboard(limit: 10)),
                  tooltip: 'Get Leaderboard',
                  child: const Text("Get Leaderboard"),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<DatabaseBloc>().add(
                      DatabaseAddScore(
                          score: Score(
                              name: "test score",
                              score: 150,
                              timestamp: DateTime.now()))),
                  tooltip: 'Add Score',
                  backgroundColor: Colors.red,
                  child: const Text("Add Score"),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: pokemons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          color: Colors.lightBlue,
                          child: Center(child: Text(pokemons[index])),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: leaderboard.leaderboard.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          color: Colors.lightBlue,
                          child: Center(
                              child: Text(leaderboard.leaderboard[index].name)),
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context
                .read<DatabaseBloc>()
                .add(const DatabaseGetPokemonsList(limit: 10)),
            tooltip: 'Get pokemon list for testing',
            child: const Text("Get Pokemons"),
          ),
        );
      },
    );
  }
}
