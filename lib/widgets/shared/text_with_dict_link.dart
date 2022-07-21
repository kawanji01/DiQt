import 'package:booqs_mobile/widgets/shared/line_with_dict_link.dart';
import 'package:flutter/material.dart';

class TextWithDictLink extends StatelessWidget {
  const TextWithDictLink(
      {Key? key,
      required this.text,
      required this.langNumber,
      required this.autoLinkEnabled,
      required this.crossAxisAlignment,
      required this.dictionaryId})
      : super(key: key);
  final String text;
  final int? langNumber;
  final int? dictionaryId;
  final bool autoLinkEnabled;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    // テキストWidgetの行ごとのリスト
    List<Widget> _textWithLinkWidgetList(String text) {
      // テキストを行ごとに分けてリストにする。
      final lines = text.split('\n');
      List<Widget> textWithLinkWidgetList = <Widget>[];

      for (String line in lines) {
        Widget textWithLink = LineWithDictLink(
          line: line,
          dictionaryId: dictionaryId,
          autoLinkEnabled: autoLinkEnabled,
        );
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
