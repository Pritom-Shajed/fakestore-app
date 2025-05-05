import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class AppLoaders {
  static Widget spinningLines({Key? key, double? size, Color? color}) {
    return SpinKitThreeBounce(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget pulse({Key? key, double? size, Color? color}) {
    return SpinKitPulse(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget wave({Key? key, double? size, Color? color}) {
    return SpinKitWave(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget dancingSquare({Key? key, double? size, Color? color}) {
    return SpinKitDancingSquare(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget foldingCube({Key? key, double? size, Color? color}) {
    return SpinKitFoldingCube(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget cubeGrid({Key? key, double? size, Color? color}) {
    return SpinKitCubeGrid(key: key, color: color ?? kPrimaryColor, size: size ?? 25);
  }

  static Widget loaderWithText(BuildContext context, {String? text, Widget? loaderWidget}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 14,
        children: [loaderWidget ?? AppLoaders.cubeGrid(), Text(text ?? 'Loading...', style: context.text.bodySmall!)],
      ),
    );
  }
}
