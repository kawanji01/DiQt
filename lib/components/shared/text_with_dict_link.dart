import 'package:booqs_mobile/components/shared/line_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/rich_dict_link_text.dart';
import 'package:booqs_mobile/components/markdown/dict_link_screen.dart';
import 'package:flutter/material.dart';

class TextWithDictLink extends StatelessWidget {
  const TextWithDictLink(
      {super.key,
      required this.text,
      required this.langNumber,
      required this.autoLinkEnabled,
      required this.crossAxisAlignment,
      required this.dictionaryId,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor,
      required this.selectable,
      this.textDirection});
  final String text;
  final int? langNumber;
  final int? dictionaryId;
  final bool autoLinkEnabled;
  final CrossAxisAlignment crossAxisAlignment;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final bool selectable;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    // 右横書き言語の場合はRichDictLinkTextで段落全体を表示
    if (textDirection == TextDirection.rtl) {
      return RichDictLinkText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontColor: fontColor,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        autoLinkEnabled: autoLinkEnabled,
        onLinkTap: (keyword) {
          if (dictionaryId == null) return;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            builder: (context) => MarkdownDictLinkScreen(
              dictionaryId: dictionaryId!,
              keyword: keyword,
            ),
          );
        },
      );
    }
    // テキストWidgetの行ごとのリスト
    List<Widget> textWithLinkWidgetList(String text) {
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
            selectable: selectable,
            textDirection: textDirection);
        if (textDirection == TextDirection.rtl) {
          textWithLink = Align(
            alignment: Alignment.centerRight,
            child: textWithLink,
          );
        }
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
        textDirection: textDirection,
        children: textWithLinkWidgetList(text),
      ),
    );
  }
}
