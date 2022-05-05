import 'package:flutter/material.dart';

class LargeGreenButton extends StatelessWidget {
  const LargeGreenButton({Key? key, required this.label, required this.icon})
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
            text: ' $label',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
      ]));
    } else {
      richText = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.white,
            size: 22.0,
          ),
        ),
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
      ]));
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: const Color(0xff84bf53).withAlpha(100),
                offset: const Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2)
          ],
          color: Colors.green),
      child: richText,
    );
  }
}
