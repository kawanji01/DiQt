import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DiQtLinkBuilder extends MarkdownElementBuilder {
  final BuildContext context;
  final double fontSize;
  final FontWeight fontWeight;
  final int? dictionaryId;

  DiQtLinkBuilder(
      this.context, this.fontSize, this.fontWeight, this.dictionaryId);
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // 独自の処理を実装します。ここでは、カスタムタグ内のテキストを取得し、テキストを赤色にして返します。
    final String text = element.textContent;
    //
    final TextStyle textStyle = TextStyle(
      color: Colors.green,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: TextDecoration.underline,
    );

    // [[表示語|検索語]]の場合
    if (text.contains('|')) {
      final displayedWord = text.split('|')[0];
      final searchedWord = text.split('|')[1];
      return RichText(
        text: TextSpan(
          style: preferredStyle,
          children: [
            TextSpan(
              text: displayedWord,
              style: textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  // 画面遷移の処理を実装します。
                  await DictionaryWordSearchResultsPage.push(
                      context, dictionaryId!, searchedWord);
                },
            ),
          ],
        ),
      );
    }

    // テキスト（[[リンク]]）のような文章で")"が改行されてしまうような、リンクの後の不自然な改行を防ぐためにRichTextを使う。
    return RichText(
      text: TextSpan(
        style: preferredStyle,
        children: [
          TextSpan(
            text: text,
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // 画面遷移の処理を実装します。
                await DictionaryWordSearchResultsPage.push(
                    context, dictionaryId!, text);
              },
          ),
        ],
      ),
    );
  }
}
