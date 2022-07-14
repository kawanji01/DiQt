import 'package:booqs_mobile/utils/markdown/diqt_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWithDiQtLink extends StatelessWidget {
  const MarkdownWithDiQtLink(
      {Key? key,
      required this.text,
      required this.dictionaryId,
      required this.textStyle})
      : super(key: key);
  final String text;
  final int? dictionaryId;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    if (dictionaryId == null) {
      return MarkdownBody(
        data: text,
        shrinkWrap: true,
        selectable: true,
        styleSheet: MarkdownStyleSheet(p: textStyle),
      );
    }
    return MarkdownBody(
      data: text,
      shrinkWrap: true,
      builders: <String, MarkdownElementBuilder>{
        'diqtlink': DiQtLinkBuilder(),
      },
      inlineSyntaxes: [DiQtLinkSyntax(dictionaryId!)],
      selectable: true,
      styleSheet: MarkdownStyleSheet(p: textStyle),
    );
  }
}
