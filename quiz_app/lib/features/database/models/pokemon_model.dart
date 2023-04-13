import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Pokemon.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Pokemon(
      name: doc.data()!['name'],
      image: doc.data()!['image'],
      pokedexId: doc.data()!['pokedex_id'],
      answers: doc.data()!['answers'],
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
