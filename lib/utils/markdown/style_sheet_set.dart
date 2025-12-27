import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownStyleSheetSet {
  static MarkdownStyleSheet normal(double fontSize, FontWeight fontWeight,
      double lineHeight, Color fontColor) {
    final h1FontSize = fontSize + 12.0;
    final h2FontSize = fontSize + 8.0;
    final h3FontSize = fontSize + 4.0;
    return MarkdownStyleSheet(
        p: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
            height: lineHeight),
        h1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: h1FontSize,
        ),
        h1Padding: const EdgeInsets.only(top: 32),
        h2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: h2FontSize,
        ),
        h2Padding: const EdgeInsets.only(top: 24),
        h3: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: h3FontSize,
        ),
        h3Padding: const EdgeInsets.only(top: 16),
        listBulletPadding: const EdgeInsets.symmetric(vertical: 16),
        a: const TextStyle(
          color: Colors.green,
          decoration: TextDecoration.underline,
        ),
        strong: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
        blockquoteDecoration: const BoxDecoration(
          color: Color(0xfff3f3f4),
        ),
        blockquotePadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 8));
  }
}
