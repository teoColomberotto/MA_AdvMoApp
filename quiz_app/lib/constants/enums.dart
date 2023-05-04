//create enum questionStatus
enum QuestionStatus { active, inactive }

enum AnswerStatus { unanswered, correct, incorrect }

enum AppLifecycleStateEvent { resumed, inactive, paused }

enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
  unknown,
  shadow;

  String toJson() => name;
  static PokemonType fromJson(String json) => values.byName(json);
}
