import 'package:booqs_mobile/components/markdown/dict_link_screen.dart';
import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class LineWithDictLink extends StatelessWidget {
  const LineWithDictLink(
      {super.key,
      required this.line,
      required this.dictionaryId,
      required this.autoLinkEnabled,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable,
      this.textDirection});
  final String line;
  final int? dictionaryId;
  final bool autoLinkEnabled;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final double fontHeight = fontSize / 10;
    // 辞書IDが設定されていないなら、
    if (dictionaryId == null) {
      return MarkdownWithoutDictLink(
        text: line,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontColor: fontColor,
        selectable: selectable,
      );
    }

    final ButtonStyle buttonStyle = ButtonStyle(
      // paddingを消す
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    Future goToWordSearchPage(keyword) async {
      return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) => MarkdownDictLinkScreen(
          dictionaryId: dictionaryId!,
          keyword: keyword,
        ),
      );
    }

    // 記法なしの単語
    // 自動でリンクをつけるならtrue, 記法でのみリンクをつける場合はfalse
    Widget plainWord(String word) {
      final bool isWhitespace = word.trim().isEmpty;
      if (autoLinkEnabled && !isWhitespace) {
        return TextButton(
          style: buttonStyle,
          onPressed: () => goToWordSearchPage(word),
          child: Text(word,
              textDirection: textDirection,
              textAlign: textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: fontHeight,
                decoration: TextDecoration.underline,
                decorationColor: fontColor,
                decorationThickness: 0.5,
              )),
        );
      }

      if (isWhitespace) {
        return Text(
          word,
          textDirection: textDirection,
          textAlign:
              textDirection == TextDirection.rtl ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            color: fontColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: fontHeight,
            decoration: TextDecoration.none,
          ),
        );
      }

      return MarkdownWithoutDictLink(
        text: word,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontColor: fontColor,
        selectable: selectable,
      );
    }

    Widget wordWithDictLink(String word) {
      final linkedWord = word.replaceFirst('[[', '').replaceFirst(']]', '');
      const Color textColor = Color.fromRGBO(0, 0, 0, 0.84);

      // [[diplayedWord|searchedWord]]の場合
      if (linkedWord.contains('|')) {
        final displayedWord = linkedWord.split('|')[0];
        final searchedWord = linkedWord.split('|')[1];
        return TextButton(
          style: buttonStyle,
          onPressed: () => goToWordSearchPage(searchedWord),
          child: Text(displayedWord,
              textDirection: textDirection,
              textAlign: textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                height: fontHeight,
                fontWeight: fontWeight,
                decoration: TextDecoration.underline,
                decorationColor: textColor,
                decorationThickness: 0.5,
              )),
        );
      }
      // [[diplayedWord]]の場合
      return TextButton(
        style: buttonStyle,
        onPressed: () => goToWordSearchPage(linkedWord),
        child: Text(linkedWord,
            textDirection: textDirection,
            textAlign: textDirection == TextDirection.rtl
                ? TextAlign.right
                : TextAlign.left,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              height: fontHeight,
              fontWeight: fontWeight,
              decoration: TextDecoration.underline,
              decorationColor: textColor,
              decorationThickness: 0.5,
            )),
      );
    }

    // 単語のウィジェットを生成する。
    Widget wordWidget(String word) {
      // 記法を持たない単語
      if (RegExp(r'(\[{2}.*?\]{2})').hasMatch(word) == false) {
        return plainWord(word);
      }
      // 記法持ちの単語
      return wordWithDictLink(word);
    }

    // 記法が使われたテキストと、そうでない通常のテキストを分けてリストにする
    // セパレーターを含んでテキストを分割する。参考： https://stackoverflow.com/questions/59547040/dart-split-string-using-regular-expression-and-include-delimiters?rq=1
    List<String> allMatchesWithSep(String text, RegExp exp, [int start = 0]) {
      var result = <String>[];

      List<String> splitPreservingSpaces(String value) {
        if (value.isEmpty) return <String>[];
        final spaceExp = RegExp(r'(\s+)');
        final parts = <String>[];
        int splitStart = 0;
        for (final match in spaceExp.allMatches(value)) {
          if (match.start > splitStart) {
            parts.add(value.substring(splitStart, match.start));
          }
          parts.add(match.group(0)!);
          splitStart = match.end;
        }
        if (splitStart < value.length) {
          parts.add(value.substring(splitStart));
        }
        return parts;
      }

      // start（最初は0）で指定されたindex以降の文字列から、expの正規表現に一致するものを調べる。参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
      for (var match in exp.allMatches(text, start)) {
        // (X): substring(前回に一致した文字列の最後のindex, 今回一致した文字列の最初のindex)を指定することで「一致しなかった文字列」を抜き出す。 参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
        String notMatch = text.substring(start, match.start);
        // 「一致しなかった文字列」をリストに加える。
        // result.add(notMatch);
        // 英単語に自動でLinkをつけられるように、スペースで文字列を区切ってリストに加える
        result.addAll(splitPreservingSpaces(notMatch));
        // 一致した文字列[[text]]をリストに追加する。
        result.add(match[0]!);
        // 一致した文字列の最後のindexをstartを書き換えて、(X)を機能させる。
        start = match.end;
      }
      // 文字列のうち、一致しなかった最後尾の部分をリストに加える。
      //result.add(text.substring(start));
      result.addAll(splitPreservingSpaces(text.substring(start)));
      return result;
    }

    // [[text]]や[[text|link]]を分ける。
    List<String?> splitLineIntoWords(String textWithDictLinks) {
      final exp = RegExp(r'(\[{2}.*?\]{2})');
      final list = allMatchesWithSep(textWithDictLinks, exp);
      return list;
    }

    // 文字列を「リンク付き文字列」に変換する
    Widget lineWithDictLink(String line) {
      List<Widget> wordWidgetList = <Widget>[];
      // テキストを単語に分割してリストにする。
      List<String?> wordList = splitLineIntoWords(line);

      for (String? word in wordList) {
        wordWidgetList.add(wordWidget(word ?? ''));
      }
      // RowではなくWrapを使うことで、Widgetを横に並べたときに画面からはみ出す問題を防ぐ。
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Wrap(
          textDirection: textDirection,
          alignment: textDirection == TextDirection.rtl
              ? WrapAlignment.end
              : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: wordWidgetList,
        ),
      );
    }

    return lineWithDictLink(line);
  }
}
