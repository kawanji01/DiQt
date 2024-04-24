import 'package:flutter/material.dart';

class SmallGreenButton extends StatelessWidget {
  const SmallGreenButton({Key? key, required this.label, required this.icon})
      : super(key: key);
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (icon == null) {
      child = Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        overflow: TextOverflow.visible,
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40, // Set minimum width as per your requirement
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
