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

      final String label =
          textContent.replaceFirst('{[', '').replaceFirst(']}', '');
      final double labelFontSize = fontSize - 4;
      final double marginTop = fontSize / 2;

      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          margin: EdgeInsets.only(right: 8, top: marginTop),
          decoration: BoxDecoration(
            border: Border.all(color: fontColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: fontColor,
                fontWeight: fontWeight,
              )));

      //return MarkdownLineWithItemLabel(
      //    line: textContent,
      //    fontSize: fontSize,
      //    fontColor: fontColor,
      //    fontWeight: fontWeight,
      //    selectable: selectable);
    });
  }
}
