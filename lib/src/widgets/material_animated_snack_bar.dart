import 'package:flutter/material.dart';

import 'package:animated_snack_bar/src/types.dart';

const _infoBackgroundColor = Color.fromRGBO(80, 147, 209, 1);
const _errorBackgroundColor = Color.fromRGBO(255, 0, 0, 1);
const _successBackgroundColor = Color.fromRGBO(99, 142, 90, 1);
const _warningBackgroundColor = Color.fromRGBO(232, 145, 72, 1);

final defaultBorderRadius = BorderRadius.circular(8);

class MaterialAnimatedSnackBar extends StatelessWidget {
  const MaterialAnimatedSnackBar({
    Key? key,
    this.titleText,
    required this.messageText,
    required this.type,
    this.borderRadius,
    this.foregroundColor = Colors.white,
    this.titleTextStyle,
    this.messageTextStyle,
    this.iconData,
    this.backgroundColor,
  }) : super(key: key);

  final String? titleText;
  final String messageText;
  final AnimatedSnackBarType type;
  final BorderRadius? borderRadius;

  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final IconData? iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;

  Color? get _backgroundColor {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? defaultBorderRadius,
        color: backgroundColor ?? _backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              iconData ?? _iconData,
              color: foregroundColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleText != null)
                    Text(
                      titleText!,
                      style: titleTextStyle ??
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: foregroundColor,
                              ),
                    ),
                  Text(
                    messageText,
                    style: messageTextStyle ??
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: foregroundColor,
                            ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
