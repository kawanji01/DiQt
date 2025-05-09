import 'package:flutter/material.dart';

class ReviewLargeOutlineButton extends StatelessWidget {
  const ReviewLargeOutlineButton({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
              fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600),
          children: [
            const WidgetSpan(
              child: Icon(
                Icons.access_alarm,
                size: 22,
                color: Colors.green,
              ),
            ),
            TextSpan(
              text: " $label",
            ),
          ],
        ),
      ),
    );
  }
}
