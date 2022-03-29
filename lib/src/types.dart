/// Snack bar types for [AnimatedSnackBar]
///
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
