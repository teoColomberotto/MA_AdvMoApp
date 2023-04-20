import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pokemon-logo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
