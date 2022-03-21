import 'package:flutter/material.dart';

import 'src/raw_animated_snack_bar.dart';

const _infoColor = Color.fromRGBO(80, 147, 209, 1);
const _errorColor = Color.fromRGBO(255, 0, 0, 1);
const _successColor = Color.fromRGBO(99, 142, 90, 1);
const _warningColor = Color.fromRGBO(255, 205, 0, 1);

class AnimatedSnackBar {
  final Duration duration;
  final WidgetBuilder builder;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  AnimatedSnackBar({
    required this.duration,
    required this.builder,
    required this.borderRadius,
    this.backgroundColor,
  });

  factory AnimatedSnackBar.info({
    required String messageText,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    return AnimatedSnackBar._default(
      messageText: messageText,
      iconData: Icons.info_outline,
      backgroundColor: backgroundColor ?? _infoColor,
      borderRadius: borderRadius,
      duration: duration,
    );
  }
  factory AnimatedSnackBar.error({
    required String messageText,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    return AnimatedSnackBar._default(
      messageText: messageText,
      iconData: Icons.error_outline,
      backgroundColor: backgroundColor ?? _errorColor,
      borderRadius: borderRadius,
      duration: duration,
    );
  }
  factory AnimatedSnackBar.success({
    required String messageText,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    return AnimatedSnackBar._default(
      messageText: messageText,
      iconData: Icons.done,
      backgroundColor: backgroundColor ?? _successColor,
      borderRadius: borderRadius,
      duration: duration,
    );
  }

  factory AnimatedSnackBar.warning({
    required String messageText,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    return AnimatedSnackBar._default(
      messageText: messageText,
      iconData: Icons.warning_amber_rounded,
      backgroundColor: backgroundColor ?? _warningColor,
      borderRadius: borderRadius,
      duration: duration,
    );
  }

  factory AnimatedSnackBar._default({
    required String messageText,
    required IconData iconData,
    required Color backgroundColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) {
    duration = duration ?? const Duration(seconds: 8);
    borderRadius ??= BorderRadius.circular(10);
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final WidgetBuilder builder = ((context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: foregroundColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                children: [
                  Text(
                    messageText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: foregroundColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
    );
  }

  Future<void> show(BuildContext context) async {
    final overlay = Navigator.of(context).overlay!;
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => RawAnimatedSnackBar(
        duration: duration,
        onRemoved: () {
          entry.remove();
        },
        child: builder.call(context),
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => overlay.insert(entry),
    );
    await Future.delayed(duration);
  }
}
