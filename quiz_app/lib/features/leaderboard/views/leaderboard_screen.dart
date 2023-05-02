import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/features/leaderboard/components/leaderboard_title.dart';

import '../../../constants/breakpoints.dart';
import '../../../utils/utils.dart';
import '../bloc/leaderboard_bloc.dart';
import '../components/leaderboard_display.dart';

@RoutePage()
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaderboardBloc>().add(const LeaderboardLoad());
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return BlocListener<LeaderboardBloc, LeaderboardState>(
      listener: (context, state) {
        if (state is LeaderboardHomeButtonPressed) {
          context.router.pop();
          context.read<LeaderboardBloc>().add(LeaderboardHomePressed());
          context.read<LeaderboardBloc>().add(LeaderboardResetState());
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
                context.read<LeaderboardBloc>().add(LeaderboardHomePressed());
              },
            ),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (myDeviceType == MyDeviceType.tabletPortrait) {
              return _buildTabletPortraitLayout(context);
            } else if (myDeviceType == MyDeviceType.tabletLandscape) {
              return _buildTabletLandscapeLayout(context);
            } else if (myDeviceType == MyDeviceType.desktopPortrait) {
              return _buildDesktopPortraitLayout(context);
            } else if (myDeviceType == MyDeviceType.desktopLandscape) {
              return _buildDesktopLandscapeLayout(context);
            } else if (myDeviceType == MyDeviceType.mobilePortrait) {
              return _buildMobilePortraitLayout(context);
            } else if (myDeviceType == MyDeviceType.mobileLandscape) {
              return _buildMobileLandscapeLayout(context);
            } else {
              return const Center(child: Text('Unknown device type'));
            }
          })),
    );
  }

  Widget _buildTabletPortraitLayout(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            BoxDecoration(gradient: MyColorsGradients.myBackgroundRedGradient),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardDisplayed) {
              return Center(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const MyLeaderboardTitle(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                          MyLeaderboardDisplay(leaderboard: state.leaderboard),
                    ),
                  ),
                ]),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const MyLeaderboardTitle(),
                    const SizedBox(height: 20),
                    const Spacer(),
                    CircularProgressIndicator(
                      color: MyColors.myWhite,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            BoxDecoration(gradient: MyColorsGradients.myBackgroundRedGradient),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardDisplayed) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MyLeaderboardTitle(),
                    ),
                    Expanded(
                      child:
                          MyLeaderboardDisplay(leaderboard: state.leaderboard),
                    ),
                  ]),
                ),
              );
            } else {
              return Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Expanded(child: MyLeaderboardTitle()),
                    ),
                    const Spacer(),
                    CircularProgressIndicator(
                      color: MyColors.myWhite,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDesktopPortraitLayout(BuildContext context) {
    return Text('Desktop portrait Layout');
  }

  Widget _buildDesktopLandscapeLayout(BuildContext context) {
    return Text('Desktop landascape Layout');
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            BoxDecoration(gradient: MyColorsGradients.myBackgroundRedGradient),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardDisplayed) {
              return Center(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const MyLeaderboardTitle(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                          MyLeaderboardDisplay(leaderboard: state.leaderboard),
                    ),
                  ),
                ]),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const MyLeaderboardTitle(),
                    const SizedBox(height: 20),
                    const Spacer(),
                    CircularProgressIndicator(
                      color: MyColors.myWhite,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLandscapeLayout(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            BoxDecoration(gradient: MyColorsGradients.myBackgroundRedGradient),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardDisplayed) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MyLeaderboardTitle(),
                    ),
                    Expanded(
                      child:
                          MyLeaderboardDisplay(leaderboard: state.leaderboard),
                    ),
                  ]),
                ),
              );
            } else {
              return Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Expanded(child: MyLeaderboardTitle()),
                    ),
                    const Spacer(),
                    CircularProgressIndicator(
                      color: MyColors.myWhite,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
