import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quiz_app/constants/breakpoints.dart';

import '../../../constants/colors.dart';
import '../../../utils/utils.dart';

class MyPokemonImage extends StatelessWidget {
  final Uint8List imageData;
  final bool show;

  const MyPokemonImage(
      {super.key, required this.imageData, required this.show});

  @override
  Widget build(BuildContext context) {
    final MyDeviceType myDeviceType =
        getDeviceTypeFromMediaQuery(MediaQuery.of(context));
    return LayoutBuilder(builder: (context, constraints) {
      if (myDeviceType == MyDeviceType.tabletPortrait ||
          myDeviceType == MyDeviceType.tabletLandscape) {
        return _buildTabletLayout(constraints);
      } else {
        return _buildMobileLayout(constraints);
      }
    });
  }

  Widget _buildTabletLayout(BoxConstraints constraints) {
    if (imageData.isEmpty) {
      return const SizedBox(
        height: 512,
        width: 512,
        child: Padding(
          padding: EdgeInsets.all(80.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    switch (show) {
      case true:
        return SizedBox(
          height: 512,
          width: 512,
          child: Transform.scale(scale: 2.0, child: Image.memory(imageData)),
        );
      case false:
        return SizedBox(
          height: 512,
          width: 512,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(MyColors.myBlack, BlendMode.srcIn),
              child:
                  Transform.scale(scale: 2.0, child: Image.memory(imageData))),
        );
      default:
        return SizedBox(
          height: 512,
          width: 512,
          child: Transform.scale(
              scale: 2.0,
              child: const Image(
                  image: AssetImage('assets/images/defaultPokemonImage.png'))),
        );
    }
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    if (imageData.isEmpty) {
      return const SizedBox(
        height: 256,
        width: 256,
        child: Padding(
          padding: EdgeInsets.all(80.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    switch (show) {
      case true:
        return SizedBox(
          height: 256,
          width: 256,
          child: Image.memory(imageData),
        );
      case false:
        return SizedBox(
          height: 256,
          width: 256,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(MyColors.myBlack, BlendMode.srcIn),
              child: Image.memory(imageData)),
        );
      default:
        return const SizedBox(
          height: 256,
          width: 256,
          child:
              Image(image: AssetImage('assets/images/defaultPokemonImage.png')),
        );
    }
  }
}
