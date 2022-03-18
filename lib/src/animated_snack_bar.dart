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
      isDraggable: false,
      child: const Text('Hi'),
      top: 50,
      left: 35,
      right: 35,
    ),
  );
  WidgetsBinding.instance!.addPostFrameCallback(
    (_) => state.insert(entry),
  );
}

class _RawAnimatedSnackBar extends StatefulWidget {
  const _RawAnimatedSnackBar({
    Key? key,
    required this.duration,
    required this.child,
    required this.isDraggable,
    required this.onRemoved,
    this.top,
    this.left,
    this.right,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final bool isDraggable;
  final double? top;
  final double? left;
  final double? right;
  final VoidCallback onRemoved;

  @override
  State<_RawAnimatedSnackBar> createState() => _RawAnimatedSnackBarState();
}

class _RawAnimatedSnackBarState extends State<_RawAnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;
  bool isMoving = false;
  double offset = 50;
  bool shouldRemoveOnScaleEnd = false;
  bool removed = false;

  late double? top = widget.top;
  late double? right = widget.right;
  late double? left = widget.left;

  final duration = const Duration(milliseconds: 400);

  final GlobalKey positionedKey = GlobalKey();

  late final AnimationController animController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

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
        if (mounted && isMoving == false) {
          setState(() => isVisible = false);
          Future.delayed(const Duration(seconds: 2), () {
            if (isMoving == false) {
              remove();
            }
          });
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: positionedKey,
      duration: isMoving ? const Duration(milliseconds: 0) : duration,
      top: isVisible ? top : (top == null ? null : -100),
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: animController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + (animController.value * .1),
            child: child,
          );
        },
        child: GestureDetector(
          onScaleStart: (i) {
            if (widget.isDraggable) {
              isMoving = true;
              animController.forward();
            }
          },
          onScaleEnd: (i) {
            if (widget.isDraggable) {
              isMoving = false;
              animController.reverse();
            }
          },
          onScaleUpdate: (i) {
            if (widget.isDraggable) {
              final del = i.focalPointDelta;
              final newTop = top! + del.dy;
              if (newTop < 150) {
                if (top != null) {
                  top = top! + del.dy;
                }
                if (left != null) {
                  left = left! + del.dx;
                }
                if (right != null) {
                  right = right! - del.dx;
                }
                if (i.focalPoint.dy <
                    MediaQuery.of(context).viewPadding.top + 10) {
                  animController.reverse();
                  top = -100;
                  Future.delayed(duration, () {
                    remove();
                  });
                } else {
                  animController.forward();
                }

                // TODO(sajad): implement making box small when
                // dragging it to sides of screen

                setState(() {});
              }
            }
            // log(i.toString());
          },
          // onHorizontalDragUpdate: (i) {
          //   if (left != null) {
          //     left = left! + del.dx;
          //   } else if (right != null) {
          //     right = right! + del.dx;
          //   }

          //   setState(() {});
          // },
          // onDrag
          // onVerticalDragUpdate: (i) {
          //   final localP = i.localPosition;
          //   final del = i.delta;
          //   if (top != null) {
          //     top = top! + del.dy;
          //   } else if (bottom != null) {
          //     bottom = bottom! + del.dy;
          //   }

          //   setState(() {});
          //   log('Global: ' + i.globalPosition.toString());
          //   log('Local: ' + i.localPosition.toString());
          // },
          child: AnimatedOpacity(
            opacity: isVisible ? .9 : .3,
            duration: const Duration(milliseconds: 1000),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.amber,
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
