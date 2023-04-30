import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class MyHowToPlay extends StatefulWidget {
  const MyHowToPlay({super.key});

  @override
  MyHowToPlayState createState() => MyHowToPlayState();
}

class MyHowToPlayState extends State<MyHowToPlay> {
  final PageController _controller = PageController();

  int _currentPageIndex = 0;

  final List<String> _pageTitles = [
    'Page 1',
    'Page 2',
    'Page 3',
    'Page 4',
  ];

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  for (var i = 0; i < _pageTitles.length; i++)
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

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text('Page 1'),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text('Page 2'),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text('Page 3'),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text('Page 4'),
        ),
      ),
    );
  }
}
