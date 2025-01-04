import 'package:flutter/material.dart';

class MediumRedButton extends StatelessWidget {
  const MediumRedButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.fontSize});
  final String label;
  final IconData? icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Widget child;
    final double iconFontSize = fontSize + 4;
    if (icon == null) {
      child = Text(
        label,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
        overflow: TextOverflow.visible,
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: iconFontSize,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 60, // Set minimum width as per your requirement
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.red,
        ),
        child: child,
      ),
    );
  }
}
