import 'package:flutter/material.dart';

class SmallGreenButton extends StatelessWidget {
  const SmallGreenButton({Key? key, required this.label, required this.icon})
      : super(key: key);
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final RichText richText;

    if (icon == null) {
      richText = RichText(
          text: TextSpan(children: [
        TextSpan(
            text: label,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
    } else {
      richText = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: label,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.green,
      ),
      child: richText,
    );
  }
}
