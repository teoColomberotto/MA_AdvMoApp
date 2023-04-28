import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  //create a widget called AboutScreen
  @override
  Widget build(BuildContext context) {
    //build the widget
    return Scaffold(
      //create a scaffold
      appBar: AppBar(
        //create an appbar
        title: const Text('About'),
        //set the title of the appbar
      ),
      body: Center(
        //create a center widget
        child: Column(
          //create a column widget
          mainAxisAlignment: MainAxisAlignment.center,
          //set the main axis alignment of the column
          children: const <Widget>[
            //create a list of widgets
            Text(
              'About Screen',
              //set the text of the widget
            ),
          ],
        ),
      ),
    );
  }
}
