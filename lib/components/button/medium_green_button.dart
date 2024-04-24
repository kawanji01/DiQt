import 'package:flutter/material.dart';

class MediumGreenButton extends StatelessWidget {
  const MediumGreenButton(
      {Key? key,
      required this.label,
      required this.fontSize,
      required this.icon})
      : super(key: key);
  final String label;
  final double fontSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final iconFontSize = fontSize + 4;
    Widget child;
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
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.green,
        ),
        child: child,
      ),
    );
  }
}
