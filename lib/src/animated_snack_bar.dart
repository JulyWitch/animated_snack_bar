import 'package:animated_snack_bar/src/types.dart';
import 'package:animated_snack_bar/src/widgets/material_animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/raw_animated_snack_bar.dart';

class AnimatedSnackBar {
  final Duration duration;
  final WidgetBuilder builder;

  AnimatedSnackBar({
    this.duration = const Duration(seconds: 8),
    required this.builder,
  });

  factory AnimatedSnackBar.material(
    String messageText, {
    required AnimatedSnackBarType type,
    BorderRadius? borderRadius,
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
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => overlay.insert(entry),
    );
    await Future.delayed(duration);
  }
}