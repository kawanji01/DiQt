import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/markdown/item_label_builder.dart';
import 'package:booqs_mobile/utils/markdown/item_label_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWithoutDictLink extends StatelessWidget {
  const MarkdownWithoutDictLink(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable})
      : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final String sanitizedText = Sanitizer.removeDiQtLink(text);
    final double lineHeight = fontSize / 10;

    return MarkdownBody(
      data: sanitizedText,
      shrinkWrap: true,
      selectable: selectable,
      inlineSyntaxes: [ItemLabelSyntax()],
      builders: <String, MarkdownElementBuilder>{
        'itemLabel':
            ItemLabelBuilder(fontSize, fontWeight, fontColor, selectable),
      },
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          height: lineHeight,
        ),
      ),
    );
  }
}
