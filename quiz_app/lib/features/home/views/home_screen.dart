import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/bloc/database_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  static List<String> pokemons = [];

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
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => context
                .read<DatabaseBloc>()
                .add(const DatabaseGetPokemonsList(limit: 10)),
            tooltip: 'Get pokemon list for testing',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
