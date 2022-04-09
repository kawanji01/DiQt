import 'package:flutter/material.dart';

class SmallOutlineGreenButton extends StatelessWidget {
  const SmallOutlineGreenButton({Key? key, required this.richText})
      : super(key: key);
  final RichText richText;

  @override
  Widget build(BuildContext context) {
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
