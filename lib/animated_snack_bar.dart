import 'package:flutter/material.dart';

import 'src/raw_animated_snack_bar.dart';

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
    duration = duration ?? const Duration(seconds: 8);
    borderRadius ??= BorderRadius.circular(10);
    backgroundColor = backgroundColor ?? const Color.fromRGBO(80, 147, 209, 1);
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final WidgetBuilder builder = ((context) {
      return _buildSimpleChild(
        context,
        messageText: messageText,
        backgroundColor: backgroundColor!,
        foregroundColor: foregroundColor,
        iconData: Icons.info_outline,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
    );
  }

  static Widget _buildSimpleChild(
    BuildContext context, {
    required Color foregroundColor,
    required Color backgroundColor,
    required String messageText,
    required IconData iconData,
  }) {
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
