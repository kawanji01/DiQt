import 'package:booqs_mobile/components/markdown/dict_link_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MarkdownDictLinkText extends StatelessWidget {
  const MarkdownDictLinkText(
      {super.key,
      required this.searchedWord,
      required this.displayedWord,
      required this.dictionaryId,
      required this.preferredStyle,
      required this.textStyle});
  final String searchedWord;
  final String displayedWord;
  final int dictionaryId;
  final TextStyle? preferredStyle;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: preferredStyle,
        children: [
          TextSpan(
            text: displayedWord,
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // 辞書の検索
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  builder: (context) => MarkdownDictLinkScreen(
                    dictionaryId: dictionaryId,
                    keyword: searchedWord,
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
