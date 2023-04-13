import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(
      //       create: (context) =>
      //           AuthenticationBloc(AuthenticationRepositoryImpl())
      //             ..add(AuthenticationStarted()),
      //     ),
      //     BlocProvider(
      //       create: (context) => FormBloc(
      //           AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
      //     ),
      //     BlocProvider(
      //       create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
      //     )
      //   ],
      //   child: const MyApp(),
      // ),
      );
  Bloc.observer = AppBlocObserver();
}
