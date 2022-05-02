import 'package:flutter/material.dart';

class SmallOutlineGreenButton extends StatelessWidget {
  const SmallOutlineGreenButton({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final IconData? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    RichText richText;
    if (icon == null) {
      richText = RichText(
          text: TextSpan(children: [
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
    } else {
      richText = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.green,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold))
      ]));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: richText,
    );
  }
}
