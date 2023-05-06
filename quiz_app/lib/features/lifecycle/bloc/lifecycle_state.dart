part of 'lifecycle_bloc.dart';

abstract class LifecycleState extends Equatable {
  const LifecycleState();

  @override
  List<Object> get props => [];
}

class LifecycleInitial extends LifecycleState {}

class ResumedState extends LifecycleState {}

class InactiveState extends LifecycleState {}

class PausedState extends LifecycleState {}
