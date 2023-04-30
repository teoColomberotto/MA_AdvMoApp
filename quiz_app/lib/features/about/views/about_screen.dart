import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/about/components/about_title.dart';
import 'package:quiz_app/features/about/components/how_to_play.dart';

import '../../../constants/colors.dart';
import '../bloc/about_bloc.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  //create a widget called AboutScreen
  @override
  Widget build(BuildContext context) {
    //build the widget
    return BlocListener<AboutBloc, AboutState>(
      listener: (context, state) {
        if (state is AboutHomeButtonPressed) {
          context.router.pop();
          context.read<AboutBloc>().add(AboutHomePressed());
          context.read<AboutBloc>().add(AboutResetState());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.myBackgroundColor,
          elevation: 0,
          title: Image.asset(
            'assets/images/pokemonBrand-logo.png',
            fit: BoxFit.contain,
            height: 32,
          ),
          leading: IconButton(
            splashRadius: 25.0,
            splashColor: Colors.orangeAccent,
            icon: const Icon(Icons.chevron_left, size: 30),
            onPressed: () {
              context.read<AboutBloc>().add(AboutHomePressed());
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: MyColorsGradients.myBackgroundRedGradient,
          ),
          child: SafeArea(
            child: Center(
                child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: const [MyAboutTitle(), MyHowToPlay()],
            )),
          ),
        ),
      ),
    );
  }
}
