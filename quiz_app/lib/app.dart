import 'package:flutter/material.dart';
import 'package:quiz_app/constants/theme.dart';
import 'package:quiz_app/routes/app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: MyTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
