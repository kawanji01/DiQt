import 'package:booqs_mobile/utils/markdown/dict_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/dict_link_syntax.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_builder.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_syntax.dart';
import 'package:booqs_mobile/utils/markdown/item_label_builder.dart';
import 'package:booqs_mobile/utils/markdown/item_label_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWithDictLink extends StatelessWidget {
  const MarkdownWithDictLink({
    Key? key,
    required this.text,
    required this.dictionaryId,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    required this.selectable,
  }) : super(key: key);
  final String text;
  final int? dictionaryId;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final lineHeight = fontSize / 10;
    final TextStyle textStyle = TextStyle(
        fontSize: fontSize,
        height: lineHeight,
        fontWeight: fontWeight,
        color: fontColor);

    if (dictionaryId == null) {
      return MarkdownBody(
        data: text,
        softLineBreak: true,
        shrinkWrap: true,
        selectable: selectable,
        styleSheet: MarkdownStyleSheet(p: textStyle),
      );
    }
    return MarkdownBody(
      data: text,
      softLineBreak: true,
      shrinkWrap: true,
      inlineSyntaxes: [
        DictLinkSyntax(),
        ItemLabelSyntax(),
        EmbeddedSentenceSyntax()
      ],
      builders: <String, MarkdownElementBuilder>{
        'dictLink': DictLinkBuilder(
            fontSize, fontWeight, fontColor, dictionaryId, selectable),
        'itemLabel':
            ItemLabelBuilder(fontSize, fontWeight, fontColor, selectable),
        'embeddedSentence': EmbeddedSentenceBuilder(fontSize, selectable),
      },
      selectable: selectable,
      styleSheet: MarkdownStyleSheet(p: textStyle),
    );
  }
}
