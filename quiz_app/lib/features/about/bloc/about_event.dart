part of 'about_bloc.dart';

abstract class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object> get props => [];
}

class AboutHomePressed extends AboutEvent {}

class AboutResetState extends AboutEvent {}
