import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Pokemon extends Equatable {
  const Pokemon({
    required this.name,
    required this.image,
    required this.answers,
    required this.pokedexId,
  });

  final String name;
  final String image;
  final int pokedexId;
  final Map answers;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      image: json['image'],
      pokedexId: json['pokedexId'],
      answers: json['answers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'pokedexId': pokedexId,
      'answers': answers,
    };
  }

  @override
  List<Object?> get props => [
        name,
        image,
        pokedexId,
        answers,
      ];
}
