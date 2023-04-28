part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomePlayPressed extends HomeEvent {}

class HomeLeaderboardPressed extends HomeEvent {}

class HomeAboutPressed extends HomeEvent {}

class HomeResetState extends HomeEvent {}
