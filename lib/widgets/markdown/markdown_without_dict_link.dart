import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/markdown/item_label_builder.dart';
import 'package:booqs_mobile/utils/markdown/item_label_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWithoutDictLink extends StatelessWidget {
  const MarkdownWithoutDictLink(
      {Key? key,
      required this.text,
      required this.textStyle,
      required this.selectable})
      : super(key: key);
  final String text;
  final TextStyle textStyle;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final String sanitizedText = Sanitizer.removeDiQtLink(text);

    return MarkdownBody(
      data: sanitizedText,
      shrinkWrap: true,
      selectable: selectable,
      inlineSyntaxes: [ItemLabelSyntax(16)],
      builders: <String, MarkdownElementBuilder>{
        'itemLabel': ItemLabelBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        p: textStyle,
      ),
    );
  }
}
