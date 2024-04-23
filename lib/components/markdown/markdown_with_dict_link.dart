import 'package:booqs_mobile/utils/markdown/diqt_link_syntax.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_builder.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_syntax.dart';
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
          'DiQtLink':
              DiQtLinkBuilder(context, fontSize, fontWeight, dictionaryId),
          'embeddedSentence': EmbeddedSentenceBuilder(fontSize, selectable),
        };
        return MarkdownBody(
            data: text,
            softLineBreak: true,
            shrinkWrap: true,
            // selectableをtrueにするとDiQtLinkの後に不自然な改行が発生するため常にfalse
            // 選択したいというユーザーがいるので selectable を設定
            selectable: selectable,
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              // インライン構文のリスト
              [
                // ... は スプレッド演算子（spread operator）
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                // 以下にカスタムのインライン構文を追加
                DiQtLinkSyntax(),
                EmbeddedSentenceSyntax(),
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
  }
}
