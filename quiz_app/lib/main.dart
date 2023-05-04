import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/features/home/bloc/bloc/home_bloc.dart';
import 'features/about/bloc/about_bloc.dart';
import 'features/connectivity/bloc/connectivity_bloc.dart';
import 'features/leaderboard/bloc/leaderboard_bloc.dart';
import 'features/lifecycle/bloc/lifecycle_bloc.dart';
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

import 'constants/constants.dart' as constants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => LifecycleBloc()),
        BlocProvider(create: (context) => StorageBloc(StorageRepositoryImpl())),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl(),
              storageBloc: context.read<StorageBloc>()),
        ),
        BlocProvider(
            create: (context) => TimerBloc(
                duration: constants.timerDuration, ticker: MyTicker())),
        BlocProvider(
            create: (context) => QuizBloc(
                connectivityBloc: context.read<ConnectivityBloc>(),
                timerBloc: context.read<TimerBloc>(),
                databaseBloc: context.read<DatabaseBloc>(),
                storageBloc: context.read<StorageBloc>(),
                lifecycleBloc: context.read<LifecycleBloc>())),
        BlocProvider(
            create: (context) => HomeBloc(
                connectivityBloc: context.read<ConnectivityBloc>(),
                quizBloc: context.read<QuizBloc>())),
        BlocProvider(
            create: (context) =>
                LeaderboardBloc(databaseBloc: context.read<DatabaseBloc>())),
        BlocProvider(create: (context) => AboutBloc()),
      ],
      child: const MyApp(),
    ),
  );
  Bloc.observer = AppBlocObserver();
}
