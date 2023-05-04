import 'package:flutter/material.dart';
import 'package:quiz_app/constants/theme.dart';
import 'package:quiz_app/routes/app_router.dart';

import 'features/lifecycle/bloc/lifecycle_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  late LifecycleObserver _observer = LifecycleObserver(context);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _observer = LifecycleObserver(context);
    WidgetsBinding.instance.addObserver(_observer);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: MyTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
