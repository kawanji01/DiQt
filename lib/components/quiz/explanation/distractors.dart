import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationDistractors extends StatelessWidget {
  const QuizExplanationDistractors({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.distractor1 == '' || quiz.distractor1 == null) {
      return Container();
    }

    // 選択肢のテキスト
    Widget distractorContent(String distractor) {
      if (quiz.autoDictLinkOfAnswer) {
        return TextWithDictLink(
            text: distractor,
            langNumber: quiz.langNumberOfAnswer,
            autoLinkEnabled: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            dictionaryId: quiz.appliedDictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.red,
            selectable: false);
      }
      return MarkdownWithDictLink(
        text: distractor,
        dictionaryId: quiz.appliedDictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.red,
        selectable: false,
      );
    }

    // 実際の選択肢
    Widget distractor(String distractor) {
      return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(Icons.close, color: Colors.red, size: 24),
            ),
            // Expandedを使うと短い文章でも幅全体を埋めてしまい、結果的に左寄せになってしまうので Flexible を使う。
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: distractorContent(distractor),
              ),
            ),
          ],
        ),
      );
    }

    // 選択肢のリスト
    List<Widget> distractorWidgetList() {
      final List<Widget> widgetList = [];
      final List<String> answerTextList = [
        quiz.distractor1 ?? '',
        quiz.distractor2 ?? '',
        quiz.distractor3 ?? ''
      ];
      answerTextList.removeWhere((element) => element == '');
      answerTextList.asMap().forEach((int i, String value) {
        widgetList.add(distractor(value));
      });
      return widgetList;
    }

    return Column(children: <Widget>[
      SharedItemLabel(text: t.quizzes.distractors),
      const SizedBox(
        height: 16,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: distractorWidgetList(),
      ),
      const SizedBox(
        height: 24,
      ),
    ]);
  }
}
