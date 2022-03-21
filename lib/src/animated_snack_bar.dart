import 'package:flutter/material.dart';

import 'widgets/raw_animated_snack_bar.dart';

showAnimatedSnackBar(BuildContext context, {Duration? duration}) async {
  duration = duration ?? const Duration(seconds: 8);
  final state = Navigator.of(context).overlay!;
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => RawAnimatedSnackBar(
      duration: duration!,
      onRemoved: () {
        entry.remove();
      },
      child: const Text('Hi'),
      backgroundColor: Colors.white.withOpacity(.8)
    ),
  );
  WidgetsBinding.instance!.addPostFrameCallback(
    (_) => state.insert(entry),
  );
}

