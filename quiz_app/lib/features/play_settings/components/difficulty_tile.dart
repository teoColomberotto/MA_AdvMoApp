//create DifficultyTile stateless widget

// Path: lib/features/play_settings/components/difficulty_tile.dart

import 'package:flutter/material.dart';
import 'package:quiz_app/constants/enums.dart';

import '../../../constants/breakpoints.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';

class DifficultyTile extends StatelessWidget {
  final Difficulty difficulty;
  final Difficulty selected;
  final VoidCallback onTap;

  const DifficultyTile({
    Key? key,
    required this.difficulty,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  String mapDifficultyToText(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
      default:
        return 'Easy';
    }
  }

  AssetImage mapImageToDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return const AssetImage('assets/images/difficulty/easy.png');
      case Difficulty.medium:
        return const AssetImage('assets/images/difficulty/medium.png');
      case Difficulty.hard:
        return const AssetImage('assets/images/difficulty/hard.png');
      default:
        return const AssetImage('assets/images/difficulty/easy.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(builder: (context, constraints) {
      if (myDeviceType == MyDeviceType.mobilePortrait) {
        return _mobilePortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.mobileLandscape) {
        return _mobileLandscapeLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletPortrait) {
        return _tabletPortraitLayout(context);
      } else if (myDeviceType == MyDeviceType.tabletLandscape) {
        return _tabletLandscapeLayout(context);
      } else {
        return _mobilePortraitLayout(context);
      }
    });
  }

  Widget _mobilePortraitLayout(BuildContext context) {
    if (selected == difficulty) {
      return IgnorePointer(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 120, maxHeight: 100, minHeight: 50, minWidth: 70),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Card(
              color: MyColors.mySecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 48, maxHeight: 48),
                      child: Image(image: mapImageToDifficulty(difficulty)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          mapDifficultyToText(difficulty),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: MyColors.myBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 120, maxHeight: 100, minHeight: 50, minWidth: 70),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 48, maxHeight: 48),
                    child: Image(image: mapImageToDifficulty(difficulty)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        mapDifficultyToText(difficulty),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyColors.myBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _mobileLandscapeLayout(BuildContext context) {
    if (selected == difficulty) {
      return IgnorePointer(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 120, maxHeight: 100, minHeight: 50, minWidth: 70),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Card(
              color: MyColors.mySecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 48, maxHeight: 48),
                      child: Image(image: mapImageToDifficulty(difficulty)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          mapDifficultyToText(difficulty),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: MyColors.myBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 120, maxHeight: 100, minHeight: 50, minWidth: 70),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 48, maxHeight: 48),
                    child: Image(image: mapImageToDifficulty(difficulty)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        mapDifficultyToText(difficulty),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyColors.myBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _tabletPortraitLayout(BuildContext context) {
    if (selected == difficulty) {
      return IgnorePointer(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 200, maxHeight: 200, minHeight: 50, minWidth: 100),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Card(
              color: MyColors.mySecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 128, maxHeight: 128),
                      child: Image(image: mapImageToDifficulty(difficulty)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          mapDifficultyToText(difficulty),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyColors.myBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 200, maxHeight: 180, minHeight: 50, minWidth: 100),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 128, maxHeight: 128),
                    child: Image(image: mapImageToDifficulty(difficulty)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        mapDifficultyToText(difficulty),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.myBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _tabletLandscapeLayout(BuildContext context) {
    if (selected == difficulty) {
      return IgnorePointer(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 200, maxHeight: 200, minHeight: 50, minWidth: 100),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Card(
              color: MyColors.mySecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 128, maxHeight: 128),
                      child: Image(image: mapImageToDifficulty(difficulty)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          mapDifficultyToText(difficulty),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyColors.myBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 200, maxHeight: 180, minHeight: 50, minWidth: 100),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 128, maxHeight: 128),
                    child: Image(image: mapImageToDifficulty(difficulty)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        mapDifficultyToText(difficulty),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.myBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
