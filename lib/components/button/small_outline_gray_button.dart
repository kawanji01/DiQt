import 'package:flutter/material.dart';

class SmallOutlineGrayButton extends StatelessWidget {
  const SmallOutlineGrayButton(
      {super.key, required this.label, required this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    RichText richText;
    if (icon == null) {
      richText = RichText(
          text: TextSpan(children: [
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.bold))
      ]));
    } else {
      richText = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.black45,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.bold))
      ]));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: richText,
    );
  }
}
