import 'package:booqs_mobile/components/shared/line_with_dict_link.dart';
import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DictLinkBuilder extends MarkdownElementBuilder {
  DictLinkBuilder(this.fontSize, this.fontWeight, this.fontColor,
      this.dictionaryId, this.selectable)
      : super();
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final int? dictionaryId;
  final bool selectable;
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(builder: (context) {
      final String textContent = element.textContent;
      //final String dictionaryIdText = textContent.split('::dictionary_id=')[1];
      //final String mainText = textContent.split('::dictionary_id=')[0];
      // 辞書IDが無ければ、辞書リンクのないMarkdownを返す
      if (dictionaryId == null) {
        return MarkdownWithoutDictLink(
            text: textContent,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontColor: fontColor,
            selectable: selectable);
      }

      return LineWithDictLink(
        line: textContent,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontColor: fontColor,
        dictionaryId: dictionaryId,
        autoLinkEnabled: false,
        selectable: selectable,
      );
    });
  }
}
