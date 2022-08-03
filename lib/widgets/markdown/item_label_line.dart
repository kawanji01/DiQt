import 'package:flutter/material.dart';

class MarkdownItemLabelLine extends StatelessWidget {
  const MarkdownItemLabelLine(
      {Key? key, required this.line, required this.fontSize})
      : super(key: key);
  final String line;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final double labelFontSize = fontSize - 3.0;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(line,
            style: TextStyle(
                fontSize: labelFontSize,
                color: Colors.black87,
                fontWeight: FontWeight.bold)));
  }
}
