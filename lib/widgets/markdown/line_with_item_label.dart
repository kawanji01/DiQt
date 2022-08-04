import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class MarkdownLineWithItemLabel extends StatelessWidget {
  const MarkdownLineWithItemLabel(
      {Key? key,
      required this.line,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable})
      : super(key: key);
  final String line;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final RegExp regExp = RegExp(r'(\{\[.*?\]\})');

    Widget _plainWord(String word) {
      return MarkdownWithoutDictLink(
        text: '$word ',
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontColor: fontColor,
        selectable: selectable,
      );
    }

    Widget _wordWithItemLabel(String word) {
      final String label = word.replaceFirst('{[', '').replaceFirst(']}', '');
      final double labelFontSize = fontSize - 4;
      final double marginTop = fontSize / 2;

      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: EdgeInsets.only(right: 8, top: marginTop),
          decoration: BoxDecoration(
            border: Border.all(color: fontColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: fontColor,
                fontWeight: FontWeight.bold,
              )));
    }

    // 単語のウィジェットを生成する。
    Widget _wordWidget(String word) {
      // 記法を持たない単語
      if (regExp.hasMatch(word) == false) {
        return _plainWord(word);
      }
      // 記法持ちの単語
      return _wordWithItemLabel(word);
    }

    // 記法が使われたテキストと、そうでない通常のテキストを分けてリストにする
    // セパレーターを含んでテキストを分割する。参考： https://stackoverflow.com/questions/59547040/dart-split-string-using-regular-expression-and-include-delimiters?rq=1
    List<String> allMatchesWithSep(String text, RegExp exp, [int start = 0]) {
      var result = <String>[];
      // start（最初は0）で指定されたindex以降の文字列から、expの正規表現に一致するものを調べる。参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
      for (var match in exp.allMatches(text, start)) {
        // (X): substring(前回に一致した文字列の最後のindex, 今回一致した文字列の最初のindex)を指定することで「一致しなかった文字列」を抜き出す。 参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
        String notMatch = text.substring(start, match.start);
        // 「一致しなかった文字列」をリストに加える。
        // result.add(notMatch);
        // 英単語に自動でLinkをつけられるように、スペースで文字列を区切ってリストに加える
        notMatch.split(' ').forEach((element) {
          result.add(element);
        });
        // 一致した文字列 {[label]} をリストに追加する。
        result.add(match[0]!);
        // 一致した文字列の最後のindexをstartを書き換えて、(X)を機能させる。
        start = match.end;
      }
      // 文字列のうち、一致しなかった最後尾の部分をリストに加える。
      //result.add(text.substring(start));
      text.substring(start).split(' ').forEach((element) {
        result.add(element);
      });
      return result;
    }

    // [[text]]や[[text|link]]を分ける。
    List<String?> _splitLineIntoWords(String textWithDictLinks) {
      final list = allMatchesWithSep(textWithDictLinks, regExp);
      return list;
    }

    // 文字列を「リンク付き文字列」に変換する
    Widget _lineWithItemLabel(String line) {
      List<Widget> wordWidgetList = <Widget>[];
      // テキストを単語に分割してリストにする。
      List<String?> wordList = _splitLineIntoWords(line);

      for (String? word in wordList) {
        Widget wordWidget = _wordWidget(word!);
        wordWidgetList.add(wordWidget);
      }

      // RowではなくWrapを使うことで、Widgetを横に並べたときに画面からはみ出す問題を防ぐ。
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          // ref: https://qiita.com/ling350181/items/47c8029e53af392f0e5f
          crossAxisAlignment: WrapCrossAlignment.center,
          children: wordWidgetList,
        ),
      );
    }

    return _lineWithItemLabel(line);
  }
}
