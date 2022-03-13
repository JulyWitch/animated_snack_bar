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

  @override
  State<AnimatedSnackBar> createState() => AnimatedSnackBarState();
}

class AnimatedSnackBarState extends State<AnimatedSnackBar> {
  late final OverlayState overlayState = Overlay.of(context)!;

  late final AnimatedSnackBarThemeData errorTheme;
  late final AnimatedSnackBarThemeData successTheme;
  late final AnimatedSnackBarThemeData infoTheme;
  late final AnimatedSnackBarThemeData warningTheme;

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

  Future<void> showSnackBar({
    Duration? duration,
  }) async {
    duration = duration ?? const Duration(seconds: 8);

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => _RawAnimatedSnackBar(
        duration: duration!,
        child: const Text('Hi'),
        pushAlignment: Alignment.topCenter,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => Overlay.of(context)!.insert(overlayEntry),
    );

    // if (previousOverlay != null && previousOverlay!.mounted) {
    //   previousOverlay?.remove();
    //   previousOverlay = null;
    // }

    await Future.delayed(duration);

    // if (previousOverlay != null && previousOverlay!.mounted) {
    //   previousOverlay?.remove();
    //   previousOverlay = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RawAnimatedSnackBar extends StatefulWidget {
  const _RawAnimatedSnackBar({
    Key? key,
    required this.duration,
    required this.pushAlignment,
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final Alignment pushAlignment;
  final Widget child;

  @override
  State<_RawAnimatedSnackBar> createState() => _RawAnimatedSnackBarState();
}

class _RawAnimatedSnackBarState extends State<_RawAnimatedSnackBar> {
  bool isVisible = false;
  double offset = 50;

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
  Widget build(BuildContext context) {
    final double? top =
        widget.pushAlignment.y < 0 ? (isVisible ? offset : -100) : null;
    final double? bottom =
        widget.pushAlignment.y > 0 ? (isVisible ? offset : -100) : null;
    final double? left =
        widget.pushAlignment.x < 0 ? (isVisible ? offset : -100) : 10;
    final double? right =
        widget.pushAlignment.x > 0 ? (isVisible ? offset : -100) : 10;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onVerticalDragUpdate: (i) {
          if (i.globalPosition.dy < 120) {
            setState(() => offset = i.globalPosition.dy);
          }
          log(i.globalPosition.toString());
        },
        child: AnimatedOpacity(
          opacity: isVisible ? .9 : .3,
          duration: const Duration(milliseconds: 1000),
          child: const Material(
            color: Colors.transparent,
          ),
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
