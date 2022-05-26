import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:flutter/material.dart';

class TextWithLink extends StatelessWidget {
  const TextWithLink(
      {Key? key,
      required this.text,
      required this.autoLinkEnabled,
      required this.crossAxisAlignment,
      required this.dictionaryId})
      : super(key: key);
  final String text;
  final bool autoLinkEnabled;
  final CrossAxisAlignment crossAxisAlignment;
  final int? dictionaryId;

  @override
  Widget build(BuildContext context) {
    final int _dictionaryId = dictionaryId ?? 1;
    // 記法が使われたテキストと、そうでないテキストを分ける。
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
        // 一致した文字列[[text]]をリストに追加する。
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
    List<String?> _splitWikiText(String wikiText) {
      final exp = RegExp(r'(\[{2}.*?\]{2})');
      final list = allMatchesWithSep(wikiText, exp);
      return list;
    }

    Future _goToWordSearchPage(keyword) async {
      await DictionaryWordSearchResultsPage.push(
          context, _dictionaryId, keyword);
    }

    // 自動でリンクをつけるならtrue, Wiki記法でのみリンクをつける場合はfalse
    Widget _wordWithAutoLink(String word) {
      if (autoLinkEnabled) {
        return TextButton(
          style: ButtonStyle(
            // paddingを消す
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => _goToWordSearchPage(word),
          // splitで削除した空白を追加する
          child: Text('$word ',
              style: const TextStyle(
                  color: Colors.green, fontSize: 16, height: 1.6)),
        );
      }
      return Text('$word ',
          style: const TextStyle(
              fontSize: 16, height: 1.6, color: Colors.black87));
    }

    // テキストウィジェットを生成する。
    Widget _wordWidget(String word) {
      // 普通のテキスト
      if (RegExp(r'(\[{2}.*?\]{2})').hasMatch(word) == false) {
        return _wordWithAutoLink(word);
      }

      final linkedWord = word.replaceFirst('[[', '').replaceFirst(']]', '');

      Color wikiedTextColor = Colors.green;
      // オートリンクの場合は、オートリンクとwiki記法のリンクの区別がつかないので、wiki記法のリンクの色をオレンジにする。
      if (autoLinkEnabled) {
        wikiedTextColor = Colors.orange;
      }

      // [[diplayedWord|searchedWord]]の場合
      if (linkedWord.contains('>')) {
        final displayedWord = linkedWord.split('>')[0];
        final searchedWord = linkedWord.split('>')[1];
        return TextButton(
          style: ButtonStyle(
            // paddingを消す
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => _goToWordSearchPage(searchedWord),
          child: Text(displayedWord,
              style:
                  TextStyle(color: wikiedTextColor, fontSize: 16, height: 1.6)),
        );
      }

      // [[diplayedWord]]の場合
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => _goToWordSearchPage(linkedWord),
        child: Text(linkedWord,
            style:
                TextStyle(color: wikiedTextColor, fontSize: 16, height: 1.6)),
      );
    }

    // 文字列を「リンク付き文字列」に変換する
    Widget _textWithLink(String text) {
      List<Widget> wordWidgetList = <Widget>[];
      // テキストをリンク可能な単語に分割してリストにする。
      List<String?> wordList = _splitWikiText(text);

      for (String? word in wordList) {
        Widget wordWidget = _wordWidget(word!);
        wordWidgetList.add(wordWidget);
      }

      // RowではなくWrapを使うことで、Widgetを横に並べたときに画面からはみ出す問題を防ぐ。
      return Wrap(
        children: wordWidgetList,
      );
    }

    // テキストWidgetの行ごとのリスト
    List<Widget> _textWithLinkWidgetList(String text) {
      // テキストを行ごとに分けてリストにする。
      final lines = text.split('\n');
      List<Widget> textWithLinkWidgetList = <Widget>[];

      for (String line in lines) {
        Widget textWithLink = _textWithLink(line);
        textWithLinkWidgetList.add(textWithLink);
      }
      return textWithLinkWidgetList;
    }

    return SizedBox(
      // 幅を画面全体に広げる。これを設定しておかないと、Columnの左寄せが画面端から始まらない。
      width: double.infinity,
      // Columnにすることで文字列の改行に対応する。
      child: Column(
        // 左寄せ。
        crossAxisAlignment: crossAxisAlignment,
        children: _textWithLinkWidgetList(text),
      ),
    );
  }
}
