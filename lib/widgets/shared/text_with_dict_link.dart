import 'package:booqs_mobile/widgets/shared/line_with_dict_link.dart';
import 'package:flutter/material.dart';

class TextWithDictLink extends StatelessWidget {
  const TextWithDictLink(
      {Key? key,
      required this.text,
      required this.langNumber,
      required this.autoLinkEnabled,
      required this.crossAxisAlignment,
      required this.dictionaryId,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable})
      : super(key: key);
  final String text;
  final int? langNumber;
  final int? dictionaryId;
  final bool autoLinkEnabled;
  final CrossAxisAlignment crossAxisAlignment;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;

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
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontColor: fontColor,
            selectable: selectable);
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
