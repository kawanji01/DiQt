import 'package:flutter/material.dart';

class HeadingMediumGreen extends StatelessWidget {
  const HeadingMediumGreen({super.key, required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    const TextStyle headingTextStyle = TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 2);

    if (icon == null) {
      return Text(label, style: headingTextStyle);
    } else {
      return RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.green,
            size: 28.0,
          ),
        ),
        TextSpan(text: ' $label', style: headingTextStyle)
      ]));
    }
  }
}
