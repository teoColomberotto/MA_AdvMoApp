import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/about/components/about_title.dart';
import 'package:quiz_app/features/about/components/how_to_play.dart';

import '../../../constants/breakpoints.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';
import '../bloc/about_bloc.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  _buildVerticalSliverList(availableHeigt) {
    return <Widget>[
      SliverList(
        delegate: SliverChildListDelegate([
          const MyAboutTitle(),
          SizedBox(height: availableHeigt - 120, child: const MyHowToPlay()),
        ]),
      ),
    ];
  }

  _buildHorizzontalSliverList(availableWidth) {
    return <Widget>[
      SliverList(
        delegate: SliverChildListDelegate([
          const MyAboutTitle(),
          const SizedBox(width: 20),
          SizedBox(width: availableWidth - 240, child: const MyHowToPlay()),
        ]),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
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
    return Container(
      decoration: BoxDecoration(
        gradient: MyColorsGradients.myBackgroundRedGradient,
      ),
      child: SafeArea(
        child: Center(child: LayoutBuilder(builder: (context, constraints) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: _buildVerticalSliverList(constraints.maxHeight - 80),
          );
        })),
      ),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MyColorsGradients.myBackgroundRedGradient,
      ),
      child: SafeArea(
        child: Center(child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              slivers: _buildHorizzontalSliverList(constraints.maxWidth - 200),
            ),
          );
        })),
      ),
    );
  }

  Widget _buildDesktopPortraitLayout(BuildContext context) {
    return const Text('Desktop Portrait Layout');
  }

  Widget _buildDesktopLandscapeLayout(BuildContext context) {
    return const Text('Desktop Landscape Layout');
  }

  Widget _buildMobilePortraitLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MyColorsGradients.myBackgroundRedGradient,
      ),
      child: SafeArea(
        child: Center(child: LayoutBuilder(builder: (context, constraints) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: _buildVerticalSliverList(constraints.maxHeight),
          );
        })),
      ),
    );
  }

  Widget _buildMobileLandscapeLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MyColorsGradients.myBackgroundRedGradient,
      ),
      child: SafeArea(
        child: Center(child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              slivers: _buildHorizzontalSliverList(constraints.maxWidth),
            ),
          );
        })),
      ),
    );
  }
}
