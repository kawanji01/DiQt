import 'package:flutter/material.dart';

class SmallOutlineGrayButton extends StatelessWidget {
  const SmallOutlineGrayButton({Key? key, required this.richText})
      : super(key: key);
  // Iconを任意に利用できるように引数はRichTextにする。
  final RichText richText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: richText,
    );
  }
}
