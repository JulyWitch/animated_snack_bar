// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:animated_snack_bar/animated_snack_bar.dart';

Duration _opacityDuration = const Duration(milliseconds: 400);

class RawAnimatedSnackBar extends StatefulWidget {
  const RawAnimatedSnackBar({
    Key? key,
    required this.duration,
    required this.child,
    required this.onRemoved,
    required this.mobileSnackBarPosition,
    required this.desktopSnackBarPosition,
    required this.getInitialDy,
    this.mobilePositionSettings,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final VoidCallback onRemoved;
  final MobileSnackBarPosition mobileSnackBarPosition;
  final DesktopSnackBarPosition desktopSnackBarPosition;
  final double Function() getInitialDy;
  final MobilePositionSettings? mobilePositionSettings;

  @override
  State<RawAnimatedSnackBar> createState() => RawAnimatedSnackBarState();
}

class RawAnimatedSnackBarState extends State<RawAnimatedSnackBar> {
  bool isVisible = false;
  bool removed = false;

  double opacity = 1;

  final duration = const Duration(milliseconds: 400);

  final GlobalKey positionedKey = GlobalKey();

  void remove() {
    if (mounted && removed == false) {
      widget.onRemoved();
      removed = true;
    }
  }

  Future<void> fadeOut() {
    opacity = 0;
    setState(() {});
    return Future.delayed(_opacityDuration);
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 100),
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

  bool get isDesktop {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width > 600;
  }

  double? get top {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.topCenter:
        case DesktopSnackBarPosition.topLeft:
        case DesktopSnackBarPosition.topRight:
          if (isVisible) {
            return 70 + widget.getInitialDy();
          } else {
            return -100;
          }

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.bottomCenter:
          return null;

        default:
          throw UnimplementedError();
      }
    } else {
      if (widget.mobileSnackBarPosition == MobileSnackBarPosition.top) {
        if (isVisible) {
          return (widget.mobilePositionSettings?.topVisible ??
              70) + widget.getInitialDy();
        } else {
          return widget.mobilePositionSettings?.topInvisible ?? -100;
        }
      } else if (widget.mobileSnackBarPosition ==
          MobileSnackBarPosition.bottom) {
        return null;
      }
    }
    throw UnimplementedError();
  }

  double? get bottom {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.topCenter:
        case DesktopSnackBarPosition.topLeft:
        case DesktopSnackBarPosition.topRight:
          return null;

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.bottomCenter:
          if (isVisible) {
            return 70 + widget.getInitialDy();
          } else {
            return -100;
          }

        default:
          throw UnimplementedError();
      }
    } else {
      if (widget.mobileSnackBarPosition == MobileSnackBarPosition.top) {
        return null;
      } else if (widget.mobileSnackBarPosition ==
          MobileSnackBarPosition.bottom) {
        if (isVisible) {
          return (widget.mobilePositionSettings?.bottomVisible ??
              70) + widget.getInitialDy();
        } else {
          return widget.mobilePositionSettings?.bottomInvisible ?? -100;
        }
      }
    }
    throw UnimplementedError();
  }

  double? get left {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.topLeft:
          return 35;

        case DesktopSnackBarPosition.bottomCenter:
        case DesktopSnackBarPosition.topCenter:
          return (MediaQuery.of(context).size.width - width!) / 2;

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.topRight:
          return MediaQuery.of(context).size.width - width! - 35;

        default:
          throw UnimplementedError();
      }
    }
    return widget.mobilePositionSettings?.left ?? 35;
  }

  double? get right {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.topLeft:
          return MediaQuery.of(context).size.width - width! - 35;

        case DesktopSnackBarPosition.topCenter:
        case DesktopSnackBarPosition.bottomCenter:
          return (MediaQuery.of(context).size.width - width!) / 2;

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.topRight:
          return 35;

        default:
          throw UnimplementedError();
      }
    }
    return widget.mobilePositionSettings?.right ?? 35;
  }

  double? get width {
    if (isDesktop) {
      final width = MediaQuery.of(context).size.width;

      return (width * .4).clamp(180, 350);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: positionedKey,
      duration: duration,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: AnimatedOpacity(
        duration: _opacityDuration,
        opacity: opacity,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
