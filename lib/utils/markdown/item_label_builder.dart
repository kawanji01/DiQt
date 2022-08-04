import 'package:booqs_mobile/widgets/markdown/line_with_item_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class ItemLabelBuilder extends MarkdownElementBuilder {
  ItemLabelBuilder(
      this.fontSize, this.fontWeight, this.fontColor, this.selectable)
      : super();
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(builder: (context) {
      final String textContent = element.textContent;

      return MarkdownLineWithItemLabel(
          line: textContent,
          fontSize: fontSize,
          fontColor: fontColor,
          fontWeight: fontWeight,
          selectable: selectable);
    });
  }
}
