import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';

import 'features/database/bloc/database_bloc.dart';
import 'features/database/database_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        ),
      ],
      child: const MyApp(),
    ),
  );
  Bloc.observer = AppBlocObserver();
}
