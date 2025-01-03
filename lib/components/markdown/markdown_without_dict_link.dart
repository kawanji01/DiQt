import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_builder.dart';
import 'package:booqs_mobile/utils/markdown/embedded_sentence_syntax.dart';
import 'package:booqs_mobile/utils/markdown/style_sheet_set.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownWithoutDictLink extends StatelessWidget {
  const MarkdownWithoutDictLink(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final String sanitizedText = Sanitizer.removeDiQtLink(text);
    final double lineHeight = fontSize / 10;

    // カスタムビルダーを使用するように設定します。
    final builders = {
      'embeddedSentence': EmbeddedSentenceBuilder(fontSize, selectable),
    };

    return MarkdownBody(
      data: sanitizedText,
      shrinkWrap: true,
      softLineBreak: true,
      selectable: selectable,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
          // 以下にカスタムのインライン構文を追加,
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
      },
    );
  }
}
