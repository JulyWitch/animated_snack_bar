// Widget que vamos a utilizar tanto para el boton de filtrar la tabla como el de ordenar la tabla
import 'package:flutter/material.dart';

class AcctionButon extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final Color overlayColor;
  final String text;
  final IconData icon;
  final double borderWidth;
  final Size size;
  final Function() onClick;

  const AcctionButon({
    super.key,
    this.color = Colors.white,
    required this.text,
    required this.borderWidth,
    required this.icon,
    this.backgroundColor = Colors.white,
    required this.size,
    required this.onClick,
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        side: borderWidth > 0.0
            ? WidgetStateProperty.all(
                BorderSide(color: color, width: borderWidth))
            : null,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        overlayColor: WidgetStateProperty.all(overlayColor),
        fixedSize: WidgetStateProperty.all(size),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: 5,
          ),
          // Necesito que coja todo el resto del espacio para que se centre correctamente
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
