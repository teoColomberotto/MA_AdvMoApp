import 'package:flutter/material.dart';

import 'features/home/views/home_screen_2.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: 'Pokemon',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage2(title: 'Testing a basic quiz structure'),
    );
  }
}
