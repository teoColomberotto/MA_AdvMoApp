import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
