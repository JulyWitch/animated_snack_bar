import 'package:flutter/material.dart';

import '../animated_snack_bar.dart';

/// Snack bar types for [AnimatedSnackBar]

/// There will be a pre defined color and icon for each one of
/// these.
enum AnimatedSnackBarType {
  info,
  error,
  success,
  warning,
}

/// Snack bar position on desktop and web devices (screens with width > 600)
enum DesktopSnackBarPosition {
  topCenter,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  bottomCenter,
}

/// Snack bar position on mobile devices (screens with width <= 600)
enum MobileSnackBarPosition { top, bottom }

/// A class to implement behaviour when having multiple snack bars
/// at once,
/// See
///   [ColumnSnackBarStrategy]
///   [RemoveSnackBarStrategy]
///   [StackSnackBarStrategy]
/// for implementation
abstract class MultipleSnackBarStrategy {
  double computeDy(List<AnimatedSnackBar> snackBars, AnimatedSnackBar self);
  List<AnimatedSnackBar> onAdd(
      List<AnimatedSnackBar> snackBars, AnimatedSnackBar self);
}

/// This class will allow you to show multiple snack bars
/// in a column format with a pre-defined gap between them.
class ColumnSnackBarStrategy implements MultipleSnackBarStrategy {
  /// Space between snackbars in the column
  final double gap;

  const ColumnSnackBarStrategy({
    this.gap = 8,
  });

  @override
  double computeDy(List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    final index = snackBars.indexWhere(
      (element) => element.info.key.currentContext != null,
    );
    if (index != -1) {
      bool isDesktop =
          MediaQuery.of(snackBars[index].info.key.currentContext!).size.width >
              600;

      final olderBars = snackBars.where(
        (element) {
          bool isMobileAndSamePosition =
              (element.mobileSnackBarPosition == self.mobileSnackBarPosition &&
                  !isDesktop);
          bool isDesktopAndSamePosition = (element.desktopSnackBarPosition ==
                  self.desktopSnackBarPosition &&
              isDesktop);

          return (isMobileAndSamePosition || isDesktopAndSamePosition) &&
              (element.info.key.currentState?.isVisible ?? false) &&
              element.info.createdAt.isBefore(self.info.createdAt);
        },
      ).toList();

      return olderBars.fold<double>(0, (initialValue, element) {
        final box =
            element.info.key.currentContext!.findRenderObject() as RenderBox;

        return initialValue + box.size.height + gap;
      });
    }
    return 0;
  }

  @override
  List<AnimatedSnackBar> onAdd(
      List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    return snackBars;
  }
}

/// This class will help you when you want
/// to remove past snackbars when a new one comes in

class RemoveSnackBarStrategy implements MultipleSnackBarStrategy {
  @override
  double computeDy(List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    return 0;
  }

  @override
  List<AnimatedSnackBar> onAdd(
      List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    final index = snackBars.indexWhere(
      (element) => element.info.key.currentContext != null,
    );

    if (index != -1) {
      bool isDesktop =
          MediaQuery.of(snackBars[index].info.key.currentContext!).size.width >
              600;
      bool shouldRemove(AnimatedSnackBar element) {
        bool isMobileAndSamePosition =
            (element.mobileSnackBarPosition == self.mobileSnackBarPosition &&
                !isDesktop);
        bool isDesktopAndSamePosition =
            (element.desktopSnackBarPosition == self.desktopSnackBarPosition &&
                isDesktop);

        return element.info.createdAt.isBefore(self.info.createdAt) &&
            (isMobileAndSamePosition || isDesktopAndSamePosition);
      }

      snackBars
          .where(
        shouldRemove,
      )
          .forEach((element) {
        element.info.key.currentState?.fadeOut().then(
              (value) => element.remove(),
            );
      });

      snackBars.removeWhere(shouldRemove);

      return snackBars;
    }

    return snackBars;
  }
}

/// This class will just stack the snackbars to each other
class StackSnackBarStrategy implements MultipleSnackBarStrategy {
  @override
  double computeDy(List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    return 0;
  }

  @override
  List<AnimatedSnackBar> onAdd(
      List<AnimatedSnackBar> snackBars, AnimatedSnackBar self) {
    return snackBars;
  }
}
