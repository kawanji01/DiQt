import 'package:booqs_mobile/pages/dictionary/search_en_ja.dart';
import 'package:flutter/material.dart';

class ExplanationText extends StatelessWidget {
  const ExplanationText({Key? key, required this.expText}) : super(key: key);
  final String expText;

  @override
  Widget build(BuildContext context) {
    final lines = expText.split('\n');

    // セパレーターを含んでテキストを分割する。参考： https://stackoverflow.com/questions/59547040/dart-split-string-using-regular-expression-and-include-delimiters?rq=1
    List<String> allMatchesWithSep(String input, RegExp exp, [int start = 0]) {
      var result = <String>[];
      for (var match in exp.allMatches(input, start)) {
        result.add(input.substring(start, match.start));
        result.add(match[0]!);
        start = match.end;
      }
      result.add(input.substring(start));
      return result;
    }

    // [[text]]や[[text|link]]を分ける。
    List<String?> _splitWikiText(String wikiText) {
      final exp = RegExp(r'(\[{2}.*?\]{2})');
      final list = allMatchesWithSep(wikiText, exp);
      return list;
    }

    Future _goToSearchEnJaPage(keyword) async {
      //await Navigator.of(context).pushNamed(searchEnJaPage);
      await SearchEnJaPage.push(context, keyword);
    }

    Widget _wikiWidget(String text) {
      if (RegExp(r'(\[{2}.*?\]{2})').hasMatch(text) == false) {
        return Text(text, style: const TextStyle(fontSize: 16, height: 1.6));
      }

      final linkText = text.replaceFirst('[[', '').replaceFirst(']]', '');

      // [[diplayedText|keyword]]の場合
      if (linkText.contains('|')) {
        final displayedText = linkText.split('|')[0];
        final searchKeyword = linkText.split('|')[1];
        return TextButton(
          style: ButtonStyle(
            // paddingを消す
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => _goToSearchEnJaPage(searchKeyword),
          child: Text(displayedText,
              style: const TextStyle(
                  color: Colors.green, fontSize: 16, height: 1.6)),
        );
      }

      // [[diplayedText]]の場合
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => _goToSearchEnJaPage(linkText),
        child: Text(linkText,
            style: const TextStyle(
                color: Colors.green, fontSize: 16, height: 1.6)),
      );
    }

    List<Widget> _wikiTextList(String text) {
      List<Widget> wikiTextWidgetList = <Widget>[];
      List<String?> wikiTextList = _splitWikiText(text);

      for (String? wikiText in wikiTextList) {
        Widget wikiWidget = _wikiWidget(wikiText!);
        wikiTextWidgetList.add(wikiWidget);
      }
      return wikiTextWidgetList;
    }

    // １行のテキスト
    Widget _textline(String text) {
      // RowではなくWrapを使うことで、Widgetを横に並べたときに画面からはみ出す問題を防ぐ。
      return Wrap(
        children: _wikiTextList(text),
      );
    }

    // テキストWidgetの行ごとのリスト
    List<Widget> _textWidgetList() {
      List<Widget> textWidgetList = <Widget>[];

      for (String line in lines) {
        Widget textLine = _textline(line);
        textWidgetList.add(textLine);
      }
      return textWidgetList;
    }

    return SizedBox(
      // 幅を画面全体に広げる。これを設定しておかないと、Columnの左寄せが画面端から始まらない。
      width: double.infinity,
      child: Column(
        // 左寄せ。
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _textWidgetList(),
      ),
    );
  }
}
