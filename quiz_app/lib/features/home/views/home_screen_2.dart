import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../quizz/bloc/quiz_bloc.dart';

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Quiz loaded!')));
          } else if (state is QuizQuestionShown) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Quiz question shown!')));
          } else if (state is QuizPokemonImageDisplayed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Quiz pokemon image displayed!')));
          } else if (state is QuizError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Quiz error!')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is QuizQuestionShown) {
                return Center(
                  child: Column(
                    children: [
                      Text('Question ${state.question.pokemon.name}'),
                      const Spacer(),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Text(state.question.pokemon.name),
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              } else if (state is QuizPokemonImageDisplayed) {
                return Center(
                  child: Column(
                    children: [
                      Text('Question ${state.question.pokemon.name}'),
                      const Spacer(),
                      SizedBox(
                        height: 256,
                        width: 256,
                        child:
                            Image.memory(state.question.pokemonImage.imageData),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Text(state.question.pokemon.name),
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              } else if (state is QuizError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Error: ${state.message}'),
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [Text('No quiz loaded')],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<QuizBloc>().add(QuizStart()),
            tooltip: 'Start quiz and siplay first question',
            child: const Text("Start quiz"),
          ),
        ));
  }
}
