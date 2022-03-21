import 'package:flutter/material.dart';

import 'src/raw_animated_snack_bar.dart';

class AnimatedSnackBar {
  final Duration duration;
  final Widget child;
  final Color? backgroundColor;

  AnimatedSnackBar({
    required this.duration,
    required this.child,
    this.backgroundColor,
  });

  factory AnimatedSnackBar.info(
     {
    Duration? duration,
  }) {
    duration = duration ?? const Duration(seconds: 8);
    final child = Column(
      children: const [
        Text("Info"),
        Text("Message")
      ],
    );

    return AnimatedSnackBar(
      duration: duration,
      child: child,
      backgroundColor: Colors.blueGrey.withOpacity(.8),
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
        child: child,
        backgroundColor: Colors.white.withOpacity(.8),
      ),
    );
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => overlay.insert(entry),
    );
    await Future.delayed(duration);
  }
}
