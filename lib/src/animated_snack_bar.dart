import 'package:flutter/material.dart';

showAnimatedSnackBar(BuildContext context, {Duration? duration}) async {
  duration = duration ?? const Duration(seconds: 8);
  final state = Navigator.of(context).overlay!;
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _RawAnimatedSnackBar(
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

class _RawAnimatedSnackBar extends StatefulWidget {
  const _RawAnimatedSnackBar(
      {Key? key,
      required this.duration,
      required this.child,
      required this.onRemoved,
      this.backgroundColor})
      : super(key: key);

  final Duration duration;
  final Widget child;
  final VoidCallback onRemoved;
  final Color? backgroundColor;

  @override
  State<_RawAnimatedSnackBar> createState() => _RawAnimatedSnackBarState();
}

class _RawAnimatedSnackBarState extends State<_RawAnimatedSnackBar> {
  bool isVisible = false;
  bool removed = false;

  final duration = const Duration(milliseconds: 400);

  final GlobalKey positionedKey = GlobalKey();

  void remove() {
    if (mounted && removed == false) {
      widget.onRemoved();
    } else {
      removed = true;
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        setState(() => isVisible = true);
      },
    );
    Future.delayed(
      Duration(milliseconds: widget.duration.inMilliseconds - 2000),
      () {
        if (mounted) {
          setState(() => isVisible = false);
          Future.delayed(const Duration(seconds: 2), () {
            remove();
          });
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: positionedKey,
      duration: duration,
      top: isVisible ? 70 : -100,
      left: 35,
      right: 35,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : .3,
        duration: const Duration(milliseconds: 1000),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: widget.backgroundColor,
            height: 100,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
