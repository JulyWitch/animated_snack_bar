import 'package:flutter/material.dart';

class RawAnimatedSnackBar extends StatefulWidget {
  const RawAnimatedSnackBar(
      {Key? key,
      required this.duration,
      required this.child,
      required this.onRemoved,
       this.borderRadius,
      this.backgroundColor})
      : super(key: key);

  final Duration duration;
  final Widget child;
  final VoidCallback onRemoved;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  State<RawAnimatedSnackBar> createState() => RawAnimatedSnackBarState();
}

class RawAnimatedSnackBarState extends State<RawAnimatedSnackBar> {
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
          borderRadius: widget.borderRadius,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: widget.backgroundColor,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
