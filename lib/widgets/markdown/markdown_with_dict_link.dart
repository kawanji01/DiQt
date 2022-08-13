import 'package:booqs_mobile/utils/markdown/dict_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/dict_link_syntax.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_builder.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_syntax.dart';
import 'package:booqs_mobile/utils/markdown/item_label_builder.dart';
import 'package:booqs_mobile/utils/markdown/item_label_syntax.dart';
import 'package:booqs_mobile/utils/markdown/style_sheet_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

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

    if (dictionaryId == null) {
      return MarkdownBody(
        data: text,
        softLineBreak: true,
        shrinkWrap: true,
        selectable: selectable,
        styleSheet: MarkdownStyleSheetSet.normal(
            fontSize, fontWeight, lineHeight, fontColor),
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
        'itemLabel': ItemLabelBuilder(
          fontSize,
          fontWeight,
          fontColor,
          selectable,
        ),
        'embeddedSentence': EmbeddedSentenceBuilder(fontSize, selectable),
      },
      selectable: selectable,
      styleSheet: MarkdownStyleSheetSet.normal(
          fontSize, fontWeight, lineHeight, fontColor),
      onTapLink: (text, href, title) {
        if (href != null) {
          launch(href);
        }
      },
    );
  }
}
