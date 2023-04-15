import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'features/quizz/bloc/quiz_bloc.dart';
import 'features/quizz/bloc/timer_bloc.dart';
import 'features/quizz/models/ticker_model.dart';
import 'features/storage/bloc/storage_bloc.dart';
import 'features/storage/repository/storage_repository.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';

import 'features/database/bloc/database_bloc.dart';
import 'features/database/repository/database_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StorageBloc(StorageRepositoryImpl())),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl(),
              storageBloc: context.read<StorageBloc>()),
        ),
        BlocProvider(
            create: (context) => TimerBloc(duration: 30, ticker: MyTicker())),
        BlocProvider(
            create: (context) => QuizBloc(
                timerBloc: context.read<TimerBloc>(),
                databaseBloc: context.read<DatabaseBloc>(),
                storageBloc: context.read<StorageBloc>()))
      ],
      child: const MyApp(),
    ),
  );
  Bloc.observer = AppBlocObserver();
}
