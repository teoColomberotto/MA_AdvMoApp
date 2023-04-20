import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QuizRecapScreen extends StatelessWidget {
  const QuizRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Quiz recap Screen'),
      ),
    );
  }
}
