import 'package:flutter/material.dart';

import 'package:animated_snack_bar/src/types.dart';
import 'package:animated_snack_bar/src/widgets/material_animated_snack_bar.dart';

import 'widgets/raw_animated_snack_bar.dart';
import 'widgets/rectangle_animated_snack_bar.dart';

List<AnimatedSnackBar> _snackBars = List.empty(growable: true);

/// A class to build and show snack bars.
///
/// You can use this class to create your
/// custom snack bar using it's default constructor.
///
/// Or simply use one of factory methods
/// and pass your custom configs to them.
///
/// Remember to call [show] method after creating snack bars
/// to show them..
class AnimatedSnackBar {
  /// Pass duration you want the snack bar to be visible for.
  final Duration duration;

  /// Build your snack bar using this builder.
  /// This will be passed to [RawAnimatedSnackBar]
  /// and will be used to build your custom snack bar.
  final WidgetBuilder builder;

  /// Determine which position you want the snack bar
  /// to be displayed at for mobile.
  final MobileSnackBarPosition mobileSnackBarPosition;

  /// Determine which position you want the snack bar
  /// to be displayed at for web and desktop
  final DesktopSnackBarPosition desktopSnackBarPosition;

  final MultipleSnackBarStrategy snackBarStrategy;

  late final _SnackBarInfo info;

  AnimatedSnackBar({
    this.duration = const Duration(seconds: 8),
    this.mobileSnackBarPosition = MobileSnackBarPosition.top,
    this.desktopSnackBarPosition = DesktopSnackBarPosition.bottomLeft,
    this.snackBarStrategy = const ColumnSnackBarStrategy(),
    required this.builder,
  });

  /// Creates a material style snack bar.
  /// Remember to call [show] method to show the snack bar.
  factory AnimatedSnackBar.material(
    String messageText, {
    required AnimatedSnackBarType type,
    BorderRadius? borderRadius,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
    MultipleSnackBarStrategy snackBarStrategy = const ColumnSnackBarStrategy(),
  }) {
    final WidgetBuilder builder = ((context) {
      return MaterialAnimatedSnackBar(
        type: type,
        borderRadius: borderRadius ?? defaultBorderRadius,
        messageText: messageText,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      snackBarStrategy: snackBarStrategy,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  /// Creates a rectangle style snack bar.
  /// Remember to call [show] method to show the snack bar.
  factory AnimatedSnackBar.rectangle(
    String titleText,
    String messageText, {
    required AnimatedSnackBarType type,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
    Brightness? brightness,
    MultipleSnackBarStrategy snackBarStrategy = const ColumnSnackBarStrategy(),
  }) {
    final WidgetBuilder builder = ((context) {
      return RectangleAnimatedSnackBar(
        titleText: titleText,
        messageText: messageText,
        type: type,
        brightness: brightness ?? Theme.of(context).brightness,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      snackBarStrategy: snackBarStrategy,
      builder: builder,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  void remove() {
    if (!info.removed) {
      info.removed = true;
      info.entry.remove();
    }
  }

  /// This method will create an overlay for your snack bar
  /// and insert it to the overlay entries of navigator.
  Future<void> show(BuildContext context) async {
    final overlay = Navigator.of(context).overlay!;

    info = _SnackBarInfo(
      key: GlobalKey<RawAnimatedSnackBarState>(),
      createdAt: DateTime.now(),
    );

    void remove() {
      this.remove();
      _snackBars.remove(this);
    }

    info.entry = OverlayEntry(
      builder: (_) => RawAnimatedSnackBar(
        key: info.key,
        getInitialDy: () => snackBarStrategy.computeDy(_snackBars, this),
        duration: duration,
        onRemoved: remove,
        child: builder.call(context),
        desktopSnackBarPosition: desktopSnackBarPosition,
        mobileSnackBarPosition: mobileSnackBarPosition,
      ),
    );

    _snackBars.add(this);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => overlay.insert(info.entry),
    );

    _snackBars = snackBarStrategy.onAdd(_snackBars, this);

    await Future.delayed(duration);
  }
}

class _SnackBarInfo {
  late final OverlayEntry entry;
  final GlobalKey<RawAnimatedSnackBarState> key;
  final DateTime createdAt;
  bool removed = false;

  _SnackBarInfo({required this.key, required this.createdAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _SnackBarInfo &&
        other.entry == entry &&
        other.key == key &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => entry.hashCode ^ key.hashCode ^ createdAt.hashCode;
}

extension Cleaner on List<AnimatedSnackBar> {
  List<AnimatedSnackBar> clean() {
    return where((element) => element.info.key.currentState != null).toList();
  }
}
