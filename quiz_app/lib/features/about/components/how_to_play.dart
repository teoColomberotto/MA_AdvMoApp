import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/features/about/components/how_to_play_title.dart';
import 'package:quiz_app/features/quizz/components/image_display.dart';
import 'package:quiz_app/features/quizz/components/timer_display.dart';

import '../../../common_widgets/my_button.dart';
import '../../../constants/breakpoints.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart' as constants;
import '../../../utils/utils.dart';

class MyHowToPlay extends StatefulWidget {
  const MyHowToPlay({
    super.key,
  });

  @override
  MyHowToPlayState createState() => MyHowToPlayState();
}

class MyHowToPlayState extends State<MyHowToPlay> {
  final PageController _controller = PageController();

  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const HowToStart(),
    const HowToChoose(),
    const HowToTimer(),
    const HowToScore(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(builder: (context, constraints) {
      if (myDeviceType == MyDeviceType.mobilePortrait) {
        return _buildMobilePortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.mobileLandscape) {
        return _buildMobileLandscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletPortrait) {
        return _buildTabletPortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletLandscape) {
        return _buildTabletLandscapeLayout(context);
      } else {
        return _buildMobilePortraitLayout(context);
      }
    });
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
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

  Widget _buildMobileLandscapeLayout(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                icon: const Icon(Icons.arrow_downward),
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

  Widget _buildTabletPortraitLayout(BuildContext context) {
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

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                icon: const Icon(Icons.arrow_downward),
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
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
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
                  const Spacer(),
                  const MyHowToPlayTitle(title: 'Start a new play'),
                  const Spacer(),
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
                  const Spacer(),
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
                  const Spacer(),
                  (myDeviceType == MyDeviceType.mobileLandscape)
                      ? const Text(
                          'An active internet connection is required to properly start a new play.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'Please, mind that an active and working intenret connection is required to properly start a new play. Check your internet settings.',
                          maxLines: 1,
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
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(builder: (context, constraints) {
      if (myDeviceType == MyDeviceType.mobileLandscape) {
        return _buildMobileLandscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.mobilePortrait) {
        return _buildMobilePortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletPortrait) {
        return _buildTabletPortraitLayout(context);
      } else {
        return _buildTabletLandscapeLayout(context);
      }
    });
  }

  Widget _buildMobileLandscapeLayout(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: MyColors.myBlack,
                                ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: const [
                          MyHowToPlayTitle(title: 'Answer the question'),
                          Text(
                            'Look at the pokemon and try to guess the name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Column(
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
                              textColor: MyColors.myOnSecondaryColor,
                              backgroundColor: MyColors.mySecondaryColor,
                              text: 'Pikachu',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
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
                  const Spacer(),
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
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
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
                  const Spacer(),
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
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: MyColors.myBlack,
                                ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: const [
                          MyHowToPlayTitle(title: 'Answer the question'),
                          Text(
                            'Look at the pokemon and try to guess the name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Column(
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
                              textColor: MyColors.myOnSecondaryColor,
                              backgroundColor: MyColors.mySecondaryColor,
                              text: 'Pikachu',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class HowToTimer extends StatelessWidget {
  const HowToTimer({super.key});

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
                  const Spacer(),
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
                  const Spacer(),
                  const MyHowToPlayTitle(title: 'Mind The Timer'),
                  const Spacer(),
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
                  const Spacer(),
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
  const HowToScore({super.key});

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return Card(
      child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
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
                  const Spacer(),
                  const MyHowToPlayTitle(title: 'Submit the score'),
                  const Spacer(),
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
                  const Spacer(),
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
                  const Spacer(),
                  (myDeviceType == MyDeviceType.mobileLandscape)
                      ? const Text(
                          'An active internet connection is required to save your score.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'Please, mind that an active and working internet connection is required to properly save a score. Check your internet settings.',
                          maxLines: 1,
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
