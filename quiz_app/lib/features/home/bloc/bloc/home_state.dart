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
