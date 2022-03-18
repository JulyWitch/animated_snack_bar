import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:animated_snack_bar/src/animated_snack_bar_theme.dart';

class AnimatedSnackBar extends StatefulWidget {
  const AnimatedSnackBar({
    Key? key,
    required this.child,
    this.errorTheme,
    this.successTheme,
    this.infoTheme,
    this.warningTheme,
  }) : super(key: key);

  final Widget child;
  final AnimatedSnackBarThemeData? errorTheme;
  final AnimatedSnackBarThemeData? successTheme;
  final AnimatedSnackBarThemeData? infoTheme;
  final AnimatedSnackBarThemeData? warningTheme;

  static AnimatedSnackBarState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AnimatedSnackBarScope>()!
        ._animatedSnackBarState;
  }

  @override
  State<AnimatedSnackBar> createState() => AnimatedSnackBarState();
}

class AnimatedSnackBarState extends State<AnimatedSnackBar> {
  late final OverlayState overlayState = Overlay.of(context)!;

  late final AnimatedSnackBarThemeData errorTheme;
  late final AnimatedSnackBarThemeData successTheme;
  late final AnimatedSnackBarThemeData infoTheme;
  late final AnimatedSnackBarThemeData warningTheme;

  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

  final List<OverlayEntry> previousOverlays = List.empty(growable: true);

  @override
  void initState() {
    errorTheme = widget.errorTheme ??
        AnimatedSnackBarThemeData(
          backgroundColor: Colors.black,
          icon: const Icon(Icons.error),
        );

    successTheme = widget.successTheme ??
        AnimatedSnackBarThemeData(
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
        );

    infoTheme = widget.infoTheme ??
        AnimatedSnackBarThemeData(
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.info),
        );

    warningTheme = widget.warningTheme ??
        AnimatedSnackBarThemeData(
          backgroundColor: Colors.orange,
          icon: const Icon(Icons.warning),
        );

    super.initState();
  }

  Future<void> showInfoSnackBar({
    String? titleText,
    String? messageText,
    Duration? duration,
    Widget? content,
    VoidCallback? onTap,
  }) async {}

  Future<void> showSnackBar(
    BuildContext context, {
    Duration? duration,
  }) async {
    duration = duration ?? const Duration(seconds: 8);

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (_) => _RawAnimatedSnackBar(
        context: context,
        duration: duration!,
        child: const Text('Hi'),
        top: 50,
        left: 35,
        right: 35,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => overlayKey.currentState!.insert(overlayEntry),
    );

    // if (previousOverlay != null && previousOverlay!.mounted) {
    //   previousOverlay?.remove();
    //   previousOverlay = null;
    // }

    await Future.delayed(duration);

    overlayEntry.remove();

    // if (previousOverlay != null && previousOverlay!.mounted) {
    //   previousOverlay?.remove();
    //   previousOverlay = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: _AnimatedSnackBarScope(
        animatedSnackBarState: this,
        child: Overlay(
          key: overlayKey,
          initialEntries: [
            OverlayEntry(builder: (context) => widget.child),
          ],
        ),
      ),
    );
  }
}

class _AnimatedSnackBarScope extends InheritedWidget {
  const _AnimatedSnackBarScope({
    Key? key,
    required Widget child,
    required AnimatedSnackBarState animatedSnackBarState,
  })  : _animatedSnackBarState = animatedSnackBarState,
        super(key: key, child: child);

  final AnimatedSnackBarState _animatedSnackBarState;

  @override
  bool updateShouldNotify(_AnimatedSnackBarScope old) =>
      _animatedSnackBarState != old._animatedSnackBarState;
}

class _RawAnimatedSnackBar extends StatefulWidget {
  const _RawAnimatedSnackBar({
    Key? key,
    required this.duration,
    required this.child,
    required this.context,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final BuildContext context;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  State<_RawAnimatedSnackBar> createState() => _RawAnimatedSnackBarState();
}

class _RawAnimatedSnackBarState extends State<_RawAnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;
  double offset = 50;
  bool shouldRemoveOnScaleEnd = false;

  late double? top = widget.top;
  late double? bottom = widget.bottom;
  late double? right = widget.right;
  late double? left = widget.left;

  final GlobalKey positionedKey = GlobalKey();

  @override
  BuildContext get context => widget.context;

  late final AnimationController animController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

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
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext _) {

    return AnimatedPositioned(
      key: positionedKey,
      duration: const Duration(milliseconds: 100),
      top: isVisible ? top : (top == null ? null : -100),
      bottom: isVisible ? bottom : (bottom == null ? null : -100),
      left: isVisible ? left : (left == null ? null : -100),
      right: isVisible ? right : (right == null ? null : -100),
      child: AnimatedBuilder(
        animation: animController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + (animController.value * .1),
            child: child,
          );
        },
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Builder(builder: (context) {
            return GestureDetector(
              onScaleStart: (i) {
                animController.forward();
              },
              onScaleEnd: (i) {
                animController.reverse();
              },
              onScaleUpdate: (i) {
                final del = i.focalPointDelta;
                final newTop = top! + del.dy;
                if (newTop < 150) {
                  if (top != null) {
                    top = top! + del.dy;
                  } else if (bottom != null) {
                    bottom = bottom! + del.dy;
                  }
                  if (left != null) {
                    left = left! + del.dx;
                  }
                  if (right != null) {
                    right = right! - del.dx;
                  }
                  log(MediaQuery.of(context).viewPadding.top.toString());
                  if (i.focalPoint.dy <
                      MediaQuery.of(context).viewPadding.top) {
                    animController.reverse();
                    top = -100;
                  } else {
                    animController.forward();
                  }

                  // TODO(sajad): implement making box small when
                  // dragging it to sides of screen

                  setState(() {});
                }
                log(i.toString());
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
            );
          }),
        ),
      ),
    );
  }
}

// class AppSnackBar extends StatefulWidget {
//   const AppSnackBar({
//     Key? key,
//     required this.message,
//     required this.child,
//     required this.duration,
//     required this.type,
//     required this.onTap,
//   }) : super(key: key);

//   final String? message;
//   final Widget? child;
//   final Duration duration;
//   final SnackBarType type;
//   final VoidCallback? onTap;

//   @override
//   _AppSnackBarState createState() => _AppSnackBarState();
// }

// class _AppSnackBarState extends State<AppSnackBar> {
//   bool isVisible = false;
//   double top = 50;

//   bool initialDur = true;

//   Duration getDuration() {
//     if (initialDur) {
//       return const Duration(seconds: 1);
//     }
//     return const Duration(milliseconds: 20);
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(
//       const Duration(milliseconds: 200),
//       () {
//         setState(() => isVisible = true);
//       },
//     );
//     Future.delayed(
//       Duration(milliseconds: widget.duration.inMilliseconds - 2000),
//       () {
//         if (mounted) {
//           setState(() => isVisible = false);
//         }
//       },
//     );
//   }

//   Color get backgroundColor {
//     switch (widget.type) {
//       case SnackBarType.success:
//         return Colors.green;
//       case SnackBarType.error:
//         return Colors.red;
//       case SnackBarType.warning:
//         return Colors.orange;
//       case SnackBarType.info:
//         return Colors.blue;
//       case SnackBarType.chat:
//         return Colors.white.withOpacity(.9);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       duration: getDuration(),
//       top: isVisible ? top : -100,
//       // height: 70,
//       left: 10,
//       right: 10,
//       child: GestureDetector(
//         onVerticalDragUpdate: (i) {
//           if (i.globalPosition.dy < 120) {
//             setState(() => top = i.globalPosition.dy);
//           }
//           log(i.globalPosition.toString());
//         },
//         child: AnimatedOpacity(
//           opacity: isVisible ? .9 : .3,
//           duration: const Duration(milliseconds: 1000),
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               margin: const EdgeInsets.all(10),
//               width: MediaQuery.of(context).size.width - 20,
//               alignment: AlignmentDirectional.centerStart,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xff333333).withOpacity(.5),
//                     blurRadius: 7,
//                     spreadRadius: 0,
//                     offset: const Offset(4, 4),
//                   )
//                 ],
//                 color: backgroundColor,
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(16),
//                   onTap: widget.onTap,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 10),
//                     child: widget.message == null
//                         ? widget.child
//                         : Text(
//                             widget.message!,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1
//                                 ?.copyWith(color: Colors.white),
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
