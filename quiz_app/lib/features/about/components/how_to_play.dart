import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/features/about/components/how_to_play_title.dart';
import 'package:quiz_app/features/quizz/components/image_display.dart';
import 'package:quiz_app/features/quizz/components/timer_display.dart';

import '../../../common_widgets/my_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart' as constants;

class MyHowToPlay extends StatefulWidget {
  const MyHowToPlay({super.key});

  @override
  MyHowToPlayState createState() => MyHowToPlayState();
}

class MyHowToPlayState extends State<MyHowToPlay> {
  final PageController _controller = PageController();

  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const HowToStart(),
    HowToChoose(),
    HowToTimer(),
    HowToScore(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _currentPageIndex = (_currentPageIndex - 1) % _pages.length;
                    if (_controller.hasClients) {
                      _controller.animateToPage(
                        _currentPageIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.circle,
                        color: i == _currentPageIndex
                            ? MyColors.myWhite
                            : Colors.grey.shade300,
                        size: i == _currentPageIndex ? 12 : 8,
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    _currentPageIndex = (_currentPageIndex + 1) % _pages.length;
                    if (_controller.hasClients) {
                      _controller.animateToPage(
                        _currentPageIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: _pages,
          ),
        ),
      ],
    );
  }
}

class HowToStart extends StatelessWidget {
  const HowToStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.myBlack, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: MyColors.myBlack,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const MyHowToPlayTitle(title: 'Start a new play'),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        onPressed: () {},
                        text: 'PLAY',
                        backgroundColor: MyColors.myTertiaryColor,
                        textColor: MyColors.myOnTertiaryColor,
                      ),
                      MyButton(
                        onPressed: () {},
                        text: 'LEADERBOARD',
                        textColor: MyColors.myWhite,
                        backgroundColor: MyColors.myBlack,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Start a new game by pressing on the play button',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Feel free to navigato to the leaderboard to see other players scores',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    'Please, mind that an active and working intenret connection is required to properly start a new play. Check your internet settings.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}

class HowToChoose extends StatefulWidget {
  const HowToChoose({super.key});

  @override
  State<HowToChoose> createState() => _HowToChooseState();
}

class _HowToChooseState extends State<HowToChoose> {
  bool _imageStatus = false;
  Future<Uint8List> _loadPokemonImage() async {
    final ByteData imageData =
        await rootBundle.load('assets/images/pikachu-logo.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.myBlack, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '2',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: MyColors.myBlack,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const MyHowToPlayTitle(title: 'Answer the question'),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        'Look at the pokemon shiloutte and try to guess the name',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder(
                          future: _loadPokemonImage(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Uint8List> snapshot) {
                            if (snapshot.hasData) {
                              return FittedBox(
                                child: MyPokemonImage(
                                    imageData: snapshot.data!,
                                    show: _imageStatus),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        onPressed: () {
                          if (_imageStatus == false) {
                            setState(() {
                              _imageStatus = true;
                            });
                          }
                        },
                        backgroundColor: MyColors.mySecondaryColor,
                        text: 'Pikachu',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class HowToTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.myBlack, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: MyColors.myBlack,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const MyHowToPlayTitle(title: 'Mind The Timer'),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: MyColors.myBackgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTimerDisplay(
                            timeRemaining: constants.timerDuration % 2,
                            background: MyColors.myBackgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Be Careful, if the timer expired the current question will be considered as wrong.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}

class HowToScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.myBlack, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '4',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: MyColors.myBlack,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const MyHowToPlayTitle(title: 'Submit the score'),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        onPressed: () {},
                        text: 'SKIP',
                        textColor: MyColors.myWhite,
                        backgroundColor: MyColors.myBlack,
                      ),
                      MyButton(
                        onPressed: () {},
                        text: 'SUBMIT',
                        backgroundColor: MyColors.myTertiaryColor,
                        textColor: MyColors.myOnTertiaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Feel free to go back to the home page',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Save your score and try to beat your friends',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    'Please, mind that an active and working internet connection is required to properly save a score. Check your internet settings.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}
