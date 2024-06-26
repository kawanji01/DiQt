import 'package:flutter/material.dart';

class HeadingLargeGreen extends StatelessWidget {
  const HeadingLargeGreen({super.key, required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    const TextStyle headingTextStyle = TextStyle(
        color: Colors.green,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 2);

    return icon == null
        ? Text(label, style: headingTextStyle)
        : RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    icon,
                    color: Colors.green,
                    size: 26.0,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(text: label, style: headingTextStyle),
              ],
            ),
          );
  }
}
