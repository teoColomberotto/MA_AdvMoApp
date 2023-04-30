part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomePlayButtonPressed extends HomeState {}

class HomeLeaderboardButtonPressed extends HomeState {}

class HomeAboutButtonPressed extends HomeState {}

class HomeQuizStartRefused extends HomeState {
  final String message;

  const HomeQuizStartRefused({required this.message});

  @override
  List<Object> get props => [message];
}
