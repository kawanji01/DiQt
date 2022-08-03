import 'package:booqs_mobile/widgets/markdown/item_label_line.dart';
import 'package:booqs_mobile/widgets/markdown/line_with_item_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class ItemLabelBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(builder: (context) {
      final String textContent = element.textContent;
      final String fontSizeString = textContent.split('::fontSize=')[1];
      final double fontSize = double.parse(fontSizeString);
      final String mainText = textContent.split('::fontSize=')[0];
      return MarkdownLineWithItemLabel(
        line: mainText,
        fontSize: fontSize,
        fontColor: Colors.black87,
        fontWeight: FontWeight.bold,
      );
    });
  }
}
