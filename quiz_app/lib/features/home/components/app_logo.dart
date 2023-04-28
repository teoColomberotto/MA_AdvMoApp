import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pikachu-logo.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              scale: 0.02,
              opacity: 0.2,
              image: AssetImage('assets/images/pikachu-boxShadow.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ]),
    );
  }
}
