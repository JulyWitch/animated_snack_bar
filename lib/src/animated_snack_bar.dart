import 'package:animated_snack_bar/src/types.dart';
import 'package:animated_snack_bar/src/widgets/material_animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/colorized_rectangle_animated_snack_bar.dart';
import 'widgets/raw_animated_snack_bar.dart';

class AnimatedSnackBar {
  final Duration duration;
  final WidgetBuilder builder;
  final MobileSnackBarPosition mobileSnackBarPosition;
  final DesktopSnackBarPosition desktopSnackBarPosition;

  AnimatedSnackBar({
    this.duration = const Duration(seconds: 8),
    this.mobileSnackBarPosition = MobileSnackBarPosition.top,
    this.desktopSnackBarPosition = DesktopSnackBarPosition.bottomLeft,
    required this.builder,
  });

  factory AnimatedSnackBar.material(
    String messageText, {
    required AnimatedSnackBarType type,
    BorderRadius? borderRadius,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
  }) {
    final WidgetBuilder builder = ((context) {
      return MaterialAnimatedSnackBar(
        type: type,
        borderRadius: borderRadius ?? defaultBorderRadius,
        messageText: messageText,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  factory AnimatedSnackBar.colorizedRectangle(
    String titleText,
    String messageText, {
    required AnimatedSnackBarType type,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
    Brightness? brightness,
  }) {
    final WidgetBuilder builder = ((context) {
      return ColorizedRectangleAnimatedSnackBar(
        titleText: titleText,
        messageText: messageText,
        type: type,
        brightness: brightness ?? Theme.of(context).brightness,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  Future<void> show(BuildContext context) async {
    final overlay = Navigator.of(context).overlay!;
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => RawAnimatedSnackBar(
        duration: duration,
        onRemoved: entry.remove,
        child: builder.call(context),
        desktopSnackBarPosition: desktopSnackBarPosition,
        mobileSnackBarPosition: mobileSnackBarPosition,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => overlay.insert(entry),
    );
    await Future.delayed(duration);
  }
}
