import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class DiQtLinkBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(builder: (context) {
      final String textContent = element.textContent;
      String searchWord = '';
      String alias = '';
      if (textContent.contains('|')) {
        final match = RegExp(r'\[{2}(.*?)\|(.*?)\]{2}').firstMatch(textContent);
        alias = match![1]!;
        searchWord = match[2]!;
      } else {
        final match = RegExp(r'\[{2}(.*?)\]{2}').firstMatch(textContent);
        alias = match![1]!;
        searchWord = alias;
      }

      final int dictionaryId =
          int.parse(textContent.split('::dictionary_id=')[1]);

      Future _goToWordSearchPage(String keyword) async {
        await DictionaryWordSearchResultsPage.push(
            context, dictionaryId, keyword);
      }

      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => _goToWordSearchPage(searchWord),
        child: Text(alias,
            style: const TextStyle(
                color: Colors.green, fontSize: 16, height: 1.6)),
      );
    });
  }
}
