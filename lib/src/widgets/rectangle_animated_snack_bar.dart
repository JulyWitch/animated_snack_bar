import 'package:flutter/material.dart';

import '../types.dart';

const _infoBackgroundColor = Color.fromRGBO(85, 85, 238, 1);
const _errorBackgroundColor = Color.fromRGBO(255, 0, 0, 1);
const _successBackgroundColor = Color.fromRGBO(99, 142, 90, 1);
const _warningBackgroundColor = Color.fromRGBO(232, 145, 72, 1);

const _darkColor = Color.fromRGBO(45, 45, 40, 1);

class RectangleAnimatedSnackBar extends StatelessWidget {
  const RectangleAnimatedSnackBar({
    Key? key,
    required this.titleText,
    required this.messageText,
    required this.type,
    required this.brightness,
    this.titleTextStyle,
    this.messageTextStyle,
    this.iconData,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  final String titleText;
  final String messageText;
  final Brightness brightness;
  final AnimatedSnackBarType type;

  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final IconData? iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;

  Color? get primary {
    if (brightness == Brightness.dark) {
      return _darkColor;
    }

    return typeColor;
  }

  Color? get typeColor {
    switch (type) {
      case AnimatedSnackBarType.info:
        return _infoBackgroundColor;

      case AnimatedSnackBarType.error:
        return _errorBackgroundColor;

      case AnimatedSnackBarType.success:
        return _successBackgroundColor;

      case AnimatedSnackBarType.warning:
        return _warningBackgroundColor;

      default:
        throw UnimplementedError();
    }
  }

  IconData? get _iconData {
    switch (type) {
      case AnimatedSnackBarType.info:
        return Icons.info_outline;

      case AnimatedSnackBarType.error:
        return Icons.error_outline;

      case AnimatedSnackBarType.success:
        return Icons.done;

      case AnimatedSnackBarType.warning:
        return Icons.warning_amber_rounded;

      default:
        throw UnimplementedError();
    }
  }

  Color? get titleColor {
    if (brightness == Brightness.dark) {
      return typeColor;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor ?? primary,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              iconData ?? _iconData,
              color: foregroundColor ?? typeColor,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: titleTextStyle ??
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: titleColor,
                          ),
                ),
                Text(
                  messageText,
                  style: messageTextStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
