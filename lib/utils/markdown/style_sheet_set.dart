import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownStyleSheetSet {
  static MarkdownStyleSheet normal(double fontSize, FontWeight fontWeight,
      double lineHeight, Color fontColor) {
    return MarkdownStyleSheet(
        p: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
            height: lineHeight),
        h1Padding: const EdgeInsets.only(top: 32),
        h2Padding: const EdgeInsets.only(top: 16),
        a: const TextStyle(
          color: Colors.green,
          decoration: TextDecoration.underline,
        ),
        strong: TextStyle(color: fontColor),
        blockquoteDecoration: const BoxDecoration(
          color: Color(0xfff3f3f4),
        ),
        blockquotePadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 8));
  }
}
