import 'package:booqs_mobile/widgets/shared/line_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DiQtLinkBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(builder: (context) {
      final String textContent = element.textContent;

      final String dictionaryIdText = textContent.split('::dictionary_id=')[1];
      final String mainText = textContent.split('::dictionary_id=')[0];
      // 辞書IDが無ければ、辞書リンクのないMarkdownを返す
      if (dictionaryIdText == '') {
        return MarkdownWithoutDictLink(
            text: mainText,
            textStyle: const TextStyle(
                color: Colors.black87, fontSize: 16, height: 1.6),
            selectable: true);
      }
      final int dictionaryId = int.parse(dictionaryIdText);

      return LineWithDictLink(
          line: mainText, dictionaryId: dictionaryId, autoLinkEnabled: false);
    });
  }
}
