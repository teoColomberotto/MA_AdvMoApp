part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityUnknown extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final ConnectivityResult result;

  const ConnectivityConnected(this.result);

  @override
  List<Object> get props => [result];
}

class ConnectivityDisconnected extends ConnectivityState {}

class ConnectivityCheckInProgress extends ConnectivityState {}

class ConnectivityCheckFailed extends ConnectivityState {
  final String message;

  const ConnectivityCheckFailed({required this.message});

  @override
  List<Object> get props => [message];
}
