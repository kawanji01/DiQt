import 'package:booqs_mobile/utils/markdown/custom_tag_syntax.dart';
import 'package:booqs_mobile/utils/markdown/custom_tag_builder.dart';
import 'package:booqs_mobile/utils/markdown/style_sheet_set.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

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

    return Builder(
      builder: (context) {
        // カスタムビルダーを使用するように設定します。
        final builders = {
          'customTag':
              CustomTagBuilder(context, fontSize, fontWeight, dictionaryId)
        };
        return MarkdownBody(
            data: text,
            softLineBreak: true,
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              [
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                CustomTagSyntax(), // ここでカスタムのインライン構文を追加,
              ],
            ),
            builders: builders,
            styleSheet: MarkdownStyleSheetSet.normal(
                fontSize, fontWeight, lineHeight, fontColor),
            onTapLink: (text, href, title) {
              if (href != null) {
                WebPageLauncher.openByExternalBrowser(href);
              }
            });
      },
    );

    /* 
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
          WebPageLauncher.openByExternalBrowser(href);
        }
      },
    ); */
  }
}
